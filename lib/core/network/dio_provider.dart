import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_interceptor.dart';

class DioProvider {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl:
      'https://apdjq7fpontm374bg3p2w3gx3m0hcbwy.lambda-url.us-east-1.on.aws',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ));

    dio.interceptors.addAll([
      LogInterceptor(responseBody: true),
      AuthInterceptor(),
    ]);

    return dio;
  }
}
