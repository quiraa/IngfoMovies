import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingfo_movies/core/resources/data_states.dart';
import 'package:ingfo_movies/features/domain/usecase/get_detail_movie_usecase.dart';
import 'package:ingfo_movies/features/presentation/blocs/detail/detail_event.dart';
import 'package:ingfo_movies/features/presentation/blocs/detail/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetailMovieUseCase getDetailMovieUseCase;

  DetailBloc(this.getDetailMovieUseCase) : super(const DetailLoadingState()) {
    on<GetDetailMovieEvent>(onGetDetailMovieEvent);
  }

  void onGetDetailMovieEvent(
    GetDetailMovieEvent event,
    Emitter<DetailState> emit,
  ) async {
    final state = await getDetailMovieUseCase(
      params: DetailMovieParams(event.imdbID!),
    );

    if (state is DataSuccess) {
      emit(DetailSuccessState(state.data!));
    }

    if (state is DataError) {
      emit(DetailErrorState(state.error!));
    }
  }
}
