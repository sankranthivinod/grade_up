import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:practiceexams/core/localdb/db_helper.dart';
import 'package:practiceexams/feature/login/data/datasources/login_remote_data_source.dart';
import 'package:practiceexams/feature/login/domain/dao/user_dao.dart';
import 'package:practiceexams/feature/login/domain/repositories/login_repository_impl.dart';
import 'package:sqflite/sqflite.dart';
import '../network/api_service.dart';
import '../network/dio_provider.dart';
import 'package:practiceexams/core/di/dependency_configuration.config.dart';


final getIt = GetIt.instance;

@InjectableInit(initializerName: 'initCoreDI', preferRelativeImports: true)
Future<void> setupDependencies() async {
  getIt.initCoreDI();
}
@module
abstract class AppModule {
  // @lazySingleton
  // FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Dio provideDio() => DioProvider.createDio();


  @lazySingleton
  ApiService provideApiService(Dio dio) => ApiService(dio);

  @lazySingleton
  LoginRemoteDataSource provideLoginRemoteDataSource(Dio dio) =>
      LoginRemoteDataSource(dio);

  @lazySingleton
  LoginRepositoryImpl provideLoginRepository(LoginRemoteDataSource remote) =>
      LoginRepositoryImpl(remote);

  @lazySingleton
  UserDao provideUserDao(Database db) => UserDao(db);

  @preResolve
  Future<Database> provideDatabase() => DBHelper.initDb();

}
