// data/datasource/home_remote_datasource.dart

import 'package:flutter/cupertino.dart';
import 'package:ftfl_assignment/modules/home/data/user_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../injection/dependency_injection.dart';

abstract class HomeRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class HomeRemoteDataSourceImpl
    implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<UserModel>> getUsers() async {
    final response =
    await apiClient.get(ApiConstants.users);

    final results = response.data['results'];

    debugPrint(results.toString());

    return results
        .map<UserModel>(
          (json) => UserModel.fromJson(json),
    )
        .toList();
  }
}