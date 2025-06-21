import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

// Get the current user
    User? user = userCredential.user;

// Get ID token
    String? idToken = await user?.getIdToken();

    print("Firebase ID Token: $idToken");


  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
// Optional: for logout, signup etc.
}
