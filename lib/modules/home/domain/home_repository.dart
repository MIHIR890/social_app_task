

import 'package:ftfl_assignment/modules/home/domain/user_entity.dart';

abstract class HomeRepository {
  Future<List<UserEntity>> getUsers();
}