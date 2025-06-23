import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';
import 'package:practiceexams/feature/exam/domain/repositories/exam_repository.dart';

class FetchQuizByNameUseCase {
  final ExamRepository repository;

  FetchQuizByNameUseCase(this.repository);

  Future<QuizEntity> call(String email, String quizName) {
    return repository.fetchQuizByName(email, quizName);
  }
}
