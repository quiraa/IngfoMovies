import 'package:ingfo_movies/core/usecases/usecases.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';

class GetAllBookmarkUseCase implements UseCase<List<BookmarkEntity>, void> {
  final MovieRepository repository;

  GetAllBookmarkUseCase(this.repository);
  @override
  Future<List<BookmarkEntity>> call({void params}) {
    return repository.getAllBookmarks();
  }
}
