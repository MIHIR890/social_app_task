


import 'package:ftfl_assignment/modules/home/data/home_remote_datasource.dart';
import 'package:ftfl_assignment/modules/home/domain/home_repository.dart';
import 'package:ftfl_assignment/modules/home/domain/user_entity.dart';

class HomeRepositoryImpl
    implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(
      this.remoteDataSource,
      );

  @override
  Future<List<UserEntity>> getUsers() async {
    return await remoteDataSource.getUsers();
  }
}