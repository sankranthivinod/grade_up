abstract class RegistrationRepository {
  Future<void> registerUser({
    required String email,
    required String password,
  });
}
