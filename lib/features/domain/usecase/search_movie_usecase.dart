import 'package:ingfo_movies/core/resources/data_states.dart';
import 'package:ingfo_movies/core/usecases/usecases.dart';
import 'package:ingfo_movies/features/data/models/response/search/search_result.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';

class SearchMovieUseCase
    implements UseCase<DataState<SearchResult>, SearchMovieParams> {
  final MovieRepository repository;

  SearchMovieUseCase(this.repository);

  @override
  Future<DataState<SearchResult>> call({SearchMovieParams? params}) {
    return repository.searchMovies(params!.username);
  }
}

class SearchMovieParams {
  final String username;

  SearchMovieParams(this.username);
}
