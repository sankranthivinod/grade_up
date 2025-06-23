import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:practiceexams/core/di/dependency_configuration.dart';
import 'package:practiceexams/core/utils/secure_storage_util.dart';
import 'package:practiceexams/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:practiceexams/feature/login/data/models/user_model.dart';
import 'package:practiceexams/feature/login/data/repositories/login_repository.dart';
import 'package:practiceexams/feature/login/domain/entities/user_entity.dart';
@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl  extends LoginRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  LoginRemoteDataSource remoteDataSource;
  LoginRepositoryImpl(this.remoteDataSource);
  @override
  Future<UserModel> login(String email) async {
    final json = await remoteDataSource.login(email);
    return UserModel.fromJson(json);
  }
  @override
  Future<UserModel> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

// Get the current user
    User? user = userCredential.user;

// Get ID token
    String? idToken = await user?.getIdToken();

   await SecureStorageUtil.saveToken(idToken!);
    return await login(email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
// Optional: for logout, signup etc.
}