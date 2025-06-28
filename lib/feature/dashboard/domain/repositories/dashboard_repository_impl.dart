import 'package:injectable/injectable.dart';
import 'package:practiceexams/feature/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:practiceexams/feature/dashboard/data/models/quiz_list_model.dart';
import 'package:practiceexams/feature/dashboard/data/repositories/dashboard_repository.dart';
import 'package:practiceexams/feature/exam/data/models/quiz_model.dart';

import '../../domain/entities/quiz_list_entity.dart';

@Injectable(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<QuizListEntity> fetchUnattemptedQuizzes(String email, String subject) async {
    final json = await remoteDataSource.fetchUnattemptedQuizzes(email, subject);
    return QuizListModel.fromJson(json);
  }
}
