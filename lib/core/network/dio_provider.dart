import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_interceptor.dart';

class DioProvider {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://yourapi.com/api/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ));

    // Interceptors
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(AuthInterceptor(const FlutterSecureStorage()));

    return dio;
  }
}
