import 'package:firebase_auth/firebase_auth.dart';

class RegistrationRepositoryImpl{
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String studentClass,
  }) async {
    if (password != confirmPassword) {
      throw Exception("Passwords do not match.");
    }

    // Firebase registration logic here
    // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

// Get the current user
    User? user = userCredential.user;

// Get ID token
    String? idToken = await user?.getIdToken();

    print("Firebase ID Token: $idToken");
  }
}