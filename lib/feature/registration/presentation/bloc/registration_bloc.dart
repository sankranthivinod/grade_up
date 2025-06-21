import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practiceexams/feature/registration/bloc/registration_event.dart';
import 'package:practiceexams/feature/registration/bloc/registration_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegistrationRepository registrationRepository;

  RegisterBloc({required this.registrationRepository}) : super(const RegisterState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });
    on<ClassChanged>((event, emit) {
      emit(state.copyWith(studentClass: event.studentClass));
    });

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        await registrationRepository.register(
          name: state.name,
          email: state.email,
          phone: state.phone,
          password: state.password,
          confirmPassword: state.confirmPassword,
          studentClass: state.studentClass,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: e.toString()));
      }
    });
  }
}
