// domain/usecases/get_users_usecase.dart



import 'package:ftfl_assignment/modules/home/domain/home_repository.dart';
import 'package:ftfl_assignment/modules/home/domain/user_entity.dart';

class GetUsersUseCase {
  final HomeRepository repository;

  GetUsersUseCase(
      this.repository,
      );

  Future<List<UserEntity>> call() async {
    return await repository.getUsers();
  }
}