import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practiceexams/feature/login/repository/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isSuccess: false, isFailure: false, errorMessage: null));

      try {
        await loginRepository.signIn(email: state.email, password: state.password);

        emit(state.copyWith(isSubmitting: false, isSuccess: true, isFailure: false));
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
