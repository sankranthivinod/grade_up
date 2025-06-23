import 'package:injectable/injectable.dart';

import '../../domain/entities/quiz_list_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';
import '../models/quiz_list_model.dart';

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
