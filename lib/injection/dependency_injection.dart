import 'package:ftfl_assignment/modules/home/domain/home_repository.dart';
import 'package:ftfl_assignment/modules/home/view/home_bloc.dart';
import 'package:get_it/get_it.dart';

import '../core/network/api_client.dart';


import '../modules/home/data/home_remote_datasource.dart';
import '../modules/home/data/home_repository_impl.dart';
import '../modules/home/domain/home_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /// Core
  sl.registerLazySingleton<ApiClient>(
        () => ApiClient(),
  );

  /// DataSource
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(
      sl<ApiClient>(),
    ),
  );

  /// Repository
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
      sl<HomeRemoteDataSource>(),
    ),
  );

  /// UseCase
  sl.registerLazySingleton(
        () => GetUsersUseCase(
      sl<HomeRepository>(),
    ),
  );
  /// Home bloc
  sl.registerFactory(
        () => HomeBloc(
      sl<GetUsersUseCase>(),
    ),
  );
}