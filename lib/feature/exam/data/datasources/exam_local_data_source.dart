import 'package:injectable/injectable.dart';
import 'package:practiceexams/feature/exam/domain/dao/quiz_dao.dart';
import '../models/quiz_model.dart';

@injectable
class ExamLocalDataSource {
  final QuizDao quizDao;

  ExamLocalDataSource(this.quizDao);

  Future<void> cacheQuiz(QuizModel quiz) async {
    await quizDao.insertQuizWithQuestions(quiz);
  }

  Future<QuizModel?> getCachedQuiz(String quizName) {
    return quizDao.getQuizByName(quizName);
  }
}
