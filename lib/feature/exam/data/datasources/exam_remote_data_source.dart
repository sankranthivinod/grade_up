import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:practiceexams/feature/exam/data/models/quiz_model.dart';
@injectable
class ExamRemoteDataSource {
  final Dio dio;

  ExamRemoteDataSource(this.dio);

  Future<QuizModel> fetchQuizByName(String email, String quizName) async {
    final response = await dio.get(
      'quiz/get-by-name',
      queryParameters: {
        'quizName': quizName,
        'email': email,
      },
    );

    return QuizModel.fromJson(response.data['quiz']);
  }
}
