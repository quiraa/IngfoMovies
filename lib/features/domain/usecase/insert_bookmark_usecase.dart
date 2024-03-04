import 'package:ingfo_movies/core/usecases/usecases.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';

class InsertBookmarkUseCase implements UseCase<void, BookmarkEntity> {
  final MovieRepository repository;

  InsertBookmarkUseCase(this.repository);

  @override
  Future<void> call({BookmarkEntity? params}) {
    return repository.insertToBookmark(params!);
  }
}
