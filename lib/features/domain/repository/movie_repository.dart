import 'package:ingfo_movies/core/resources/data_states.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';
import 'package:ingfo_movies/features/data/models/response/detail/detail_movie.dart';
import 'package:ingfo_movies/features/data/models/response/search/search_result.dart';

abstract class MovieRepository {
  Future<DataState<SearchResult>> searchMovies(String query);

  Future<DataState<DetailMovie>> getDetailMovie(String imdbID);

  Future<List<BookmarkEntity>> getAllBookmarks();

  Future<void> insertToBookmark(BookmarkEntity bookmark);

  Future<void> removeFromBookmark(String imdbID);

  Future<void> deleteAllBookmark();
}
