abstract class RegisterEvent {}

class NameChanged extends RegisterEvent {
  final String name;
  NameChanged({required this.name});
}

class EmailChanged extends RegisterEvent {
  final String email;
  EmailChanged({required this.email});
}

class PhoneChanged extends RegisterEvent {
  final String phone;
  PhoneChanged({required this.phone});
}

class PasswordChanged extends RegisterEvent {
  final String password;
  PasswordChanged({required this.password});
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  ConfirmPasswordChanged({required this.confirmPassword});
}

class ClassChanged extends RegisterEvent {
  final String studentClass;
  ClassChanged({required this.studentClass});
}

class RegisterSubmitted extends RegisterEvent {}
