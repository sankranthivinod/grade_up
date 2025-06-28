import 'package:practiceexams/feature/dashboard/data/repositories/dashboard_repository.dart';
import '../entities/quiz_list_entity.dart';

class FetchQuizzesUseCase {
  final DashboardRepository repository;

  FetchQuizzesUseCase(this.repository);

  Future<QuizListEntity> call(String email, String subject) {
    return repository.fetchUnattemptedQuizzes(email, subject);
  }
}
