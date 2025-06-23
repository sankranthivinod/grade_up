

import 'package:injectable/injectable.dart';
import 'package:practiceexams/feature/login/data/models/user_model.dart';
import 'package:practiceexams/feature/login/domain/entities/user_entity.dart';
abstract class LoginRepository {
  Future<UserEntity> login(String email);
  Future<UserModel> signIn({required String email, required String password});
}