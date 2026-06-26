import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftfl_assignment/modules/home/domain/home_usecase.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUseCase getUsersUseCase;

  HomeBloc(this.getUsersUseCase) : super(HomeInitial()) {
    on<LoadUsersEvent>(_loadUsers);

    on<RefreshUsersEvent>(_refreshUsers);
  }

  Future<void> _loadUsers(
      LoadUsersEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());

    try {
      final users = await getUsersUseCase();

      emit(HomeLoaded(users));
    } catch (e) {
      emit(
        const HomeError(
          "Something Went Wrong",
        ),
      );
    }
  }

  Future<void> _refreshUsers(
      RefreshUsersEvent event,
      Emitter<HomeState> emit,
      ) async {
    try {
      final users = await getUsersUseCase();

      emit(HomeLoaded(users));
    } catch (_) {
      emit(
        const HomeError(
          "Something Went Wrong",
        ),
      );
    }
  }
}