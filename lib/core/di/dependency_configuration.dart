import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../network/dio_provider.dart';
import '../network/api_service.dart';
import 'dependency_configuration.config.dart';


final getIt = GetIt.instance;


@InjectableInit(initializerName: 'initCoreDI', preferRelativeImports: true)
void setupDependencies() {
  // Secure storage
  getIt.init();
  // getIt.registerLazySingleton(() => const FlutterSecureStorage());

  // Dio instance
  getIt.registerLazySingleton<Dio>(() => DioProvider.createDio());

  // API service
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

}

@module
abstract class AppModule{

}
