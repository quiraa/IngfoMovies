import 'package:ingfo_movies/core/usecases/usecases.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';

class RemoveBookmarkUseCase implements UseCase<void, RemoveBookmarkParams> {
  final MovieRepository repository;

  RemoveBookmarkUseCase(this.repository);

  @override
  Future<void> call({RemoveBookmarkParams? params}) {
    return repository.removeFromBookmark(params!.imdbID);
  }
}

class RemoveBookmarkParams {
  final String imdbID;

  RemoveBookmarkParams(this.imdbID);
}
