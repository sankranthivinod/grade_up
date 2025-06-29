import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';

abstract class ExamRepository {
  Future<QuizEntity> fetchAndSaveExam(String email, String quizName);
  Future<QuizEntity?> getLocalExam(String quizName);

}
