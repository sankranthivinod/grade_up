import '../entities/quiz_list_entity.dart';

abstract class DashboardRepository {
  Future<QuizListEntity> fetchUnattemptedQuizzes(String email, String subject);
}
