import 'package:injectable/injectable.dart';
import 'package:practiceexams/feature/exam/domain/dao/quiz_dao.dart';
import '../../domain/entities/quiz_entity.dart';
import '../../domain/repositories/exam_repository.dart';
import '../datasources/exam_remote_data_source.dart';

@LazySingleton(as: ExamRepository)
class ExamRepositoryImpl implements ExamRepository {
  final ExamRemoteDataSource remoteDataSource;
  final QuizDao quizDao;

  ExamRepositoryImpl(this.remoteDataSource, this.quizDao);

  @override
  Future<QuizEntity> fetchAndSaveExam(String email, String quizName) async {
    final quiz = await remoteDataSource.fetchQuizByName(email, quizName);
    await quizDao.insertQuizWithQuestions(quiz);
    return quiz;
  }

  @override
  Future<QuizEntity?> getLocalExam(String quizName) {
    return quizDao.getQuizByName(quizName);
  }
}
