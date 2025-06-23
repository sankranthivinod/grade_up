import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
@injectable
class DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> fetchUnattemptedQuizzes(String email, String category) async {
    final response = await dio.get(
      'quiz/unattempted-quizzes',
      queryParameters: {
        'category': category,
        'email': email,
      },
    );
    return response.data;
  }
}
