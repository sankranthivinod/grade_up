import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:practiceexams/core/di/dependency_configuration.dart';
import 'package:practiceexams/core/resources/constants.dart';
import 'package:practiceexams/core/utils/secure_storage_util.dart';
import 'package:practiceexams/feature/login/data/models/user_model.dart';
import 'package:practiceexams/feature/login/data/repositories/login_repository.dart';
import 'package:practiceexams/feature/login/domain/dao/user_dao.dart';
import 'package:practiceexams/feature/login/domain/entities/user_entity.dart';
import 'package:practiceexams/feature/login/domain/repositories/login_repository_impl.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = getIt<LoginRepository>();
  final UserDao userDao = getIt<UserDao>();

  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isSuccess: false, isFailure: false, errorMessage: null));

      try {
        UserModel user = await loginRepository.signIn(
          email: state.email,
          password: state.password,
        );
        final list  = await userDao.getUsers();
        if(list.isEmpty){
          // await userDao.deleteUsers();
          await userDao.insertUser(user);
        }

        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          isFailure: true,
          errorMessage: e.toString(),
        ));
      }
    });
  }
}
