import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:practiceexams/core/di/dependency_configuration.config.dart';
import '../network/api_service.dart';
import '../network/dio_provider.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'initCoreDI', preferRelativeImports: true)
void setupDependencies() {
  getIt.init();
}
@module
abstract class AppModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Dio provideDio() =>
      DioProvider.createDio();

  @lazySingleton
  ApiService provideApiService(Dio dio) => ApiService(dio);
}
