import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  /// Register a new user
  Future<Response> registerUser(Map<String, dynamic> userData) async {
    return await dio.post('students/register', data: userData);
  }

  /// Login user by email (GET with query param)
  Future<Response> loginUser(String email) async {
    return await dio.get(
      'students/get-by-email',
      queryParameters: {'email': email},
    );
  }

  /// Get unattempted quizzes for a subject and user
  Future<List<String>> fetchUnattemptedQuizzes({
    required String category,
    required String email,
  }) async {
    final response = await dio.get(
      'quiz/unattempted-quizzes',
      queryParameters: {'category': category, 'email': email},
    );
    return List<String>.from(response.data['unattempted_quizzes']);
  }

  /// Get quiz by name
  Future<Map<String, dynamic>> fetchQuizByName({
    required String quizName,
    required String email,
  }) async {
    final response = await dio.get(
      'quiz/get-by-name',
      queryParameters: {'quizName': quizName, 'email': email},
    );
    return response.data['quiz'];
  }
}
