import 'package:ingfo_movies/core/resources/data_states.dart';
import 'package:ingfo_movies/core/usecases/usecases.dart';
import 'package:ingfo_movies/features/data/models/response/detail/detail_movie.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';

class GetDetailMovieUseCase
    implements UseCase<DataState<DetailMovie>, DetailMovieParams> {
  final MovieRepository repository;

  GetDetailMovieUseCase(this.repository);

  @override
  Future<DataState<DetailMovie>> call({DetailMovieParams? params}) {
    return repository.getDetailMovie(params!.imdbID);
  }
}

class DetailMovieParams {
  final String imdbID;

  DetailMovieParams(this.imdbID);
}
