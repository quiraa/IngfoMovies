import 'package:ingfo_movies/core/usecases/usecases.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';

class DeleteAllBookmarkUseCase implements UseCase<void, void> {
  final MovieRepository repository;

  DeleteAllBookmarkUseCase(this.repository);

  @override
  Future<void> call({void params}) {
    return repository.deleteAllBookmark();
  }
}
