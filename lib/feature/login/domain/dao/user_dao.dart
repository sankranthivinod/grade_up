
import 'package:injectable/injectable.dart';
import 'package:practiceexams/feature/login/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';


class UserDao {
  final Database db;

  UserDao(this.db);

  Future<int> insertUser(UserModel userModel) async {
    return await db.insert('users', userModel.toJson());
  }

  Future<List<UserModel>> getUsers() async {
    final result = await db.query('users');
    return result.map((e) => UserModel.fromJson(e)).toList();
  }
  Future<int> deleteUsers() async {
    return await db.delete('users'); // Deletes all users
  }
}

