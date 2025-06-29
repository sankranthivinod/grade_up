import '../entities/quiz_entity.dart';
import '../repositories/exam_repository.dart';

class GetLocalExamUseCase {
  final ExamRepository repository;

  GetLocalExamUseCase(this.repository);

  Future<QuizEntity?> call(String quizName) {
    return repository.getLocalExam(quizName);
  }
}
