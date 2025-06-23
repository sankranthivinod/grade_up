import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';

abstract class ExamRepository {
  Future<QuizEntity> fetchQuizByName(String email, String quizName);
}
