import 'package:practiceexams/feature/exam/data/datasources/exam_remote_data_source.dart';
import 'package:practiceexams/feature/exam/domain/entities/quiz_entity.dart';
import 'package:practiceexams/feature/exam/domain/repositories/exam_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamRepository)
class ExamRepositoryImpl implements ExamRepository {
  final ExamRemoteDataSource remoteDataSource;

  ExamRepositoryImpl(this.remoteDataSource);

  @override
  Future<QuizEntity> fetchQuizByName(String email, String quizName) {
    return remoteDataSource.fetchQuizByName(email, quizName);
  }
}
