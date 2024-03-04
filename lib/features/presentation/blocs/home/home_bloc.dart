import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingfo_movies/core/resources/data_states.dart';
import 'package:ingfo_movies/features/domain/usecase/search_movie_usecase.dart';
import 'package:ingfo_movies/features/presentation/blocs/home/home_event.dart';
import 'package:ingfo_movies/features/presentation/blocs/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SearchMovieUseCase searchMovieUseCase;

  HomeBloc(this.searchMovieUseCase) : super(const HomeDefaultState()) {
    on<SearchMovieEvent>(onSearchMovieEvent);
  }

  void onSearchMovieEvent(
    SearchMovieEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadingState());

    final state = await searchMovieUseCase(
      params: SearchMovieParams(event.query!),
    );

    if (state is DataSuccess) {
      emit(HomeSuccessState(state.data!));
    }

    if (state is DataError) {
      emit(HomeErrorState(state.error!));
    }
  }
}
