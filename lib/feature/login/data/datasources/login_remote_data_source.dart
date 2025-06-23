import 'package:dio/dio.dart';

class LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> login(String email) async {

    final response = await dio.get(
      'students/get-by-email',
      queryParameters: {'email': email},
    );

    return response.data;
  }
}