import 'package:practiceexams/feature/login/data/repositories/login_repository.dart';
import 'package:practiceexams/feature/login/domain/entities/user_entity.dart';

class GetLoginUseCase {

  final LoginRepository repository;

  GetLoginUseCase(this.repository);

  Future<UserEntity> call(String email) {
    return repository.login(email);
  }
}
