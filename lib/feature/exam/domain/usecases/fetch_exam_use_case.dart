import '../entities/quiz_entity.dart';
import '../repositories/exam_repository.dart';

class FetchExamUseCase {
  final ExamRepository repository;

  FetchExamUseCase(this.repository);

  Future<QuizEntity> call(String email, String quizName) {
    return repository.fetchAndSaveExam(email, quizName);
  }
}
