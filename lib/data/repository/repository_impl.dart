import 'package:flutter_api/data/repository/repository.dart';
import 'package:flutter_api/data/source/api/api_service.dart';
import 'package:flutter_api/data/source/db/bookmark_dao.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';
import 'package:flutter_api/domain/models/detail/detail_movie.dart';
import 'package:flutter_api/domain/models/search/search_result.dart';

class RepositoryImpl implements Repository {
  final BookmarkDao _dao;
  final ApiService _api;

  RepositoryImpl({required BookmarkDao dao, required ApiService api})
      : _dao = dao,
        _api = api;

  @override
  Future<void> addToBookmark(Bookmark bookmark) {
    return _dao.addToBookmark(bookmark);
  }

  @override
  Future<void> deleteAllBookmark() {
    return _dao.deleteAllBookmark();
  }

  @override
  Future<List<Bookmark>> getAllBookmark() {
    return _dao.getAllBookmarks();
  }

  @override
  Future<DetailMovie> getMovieDetail(String apiKey, String imdbID) {
    return _api.getMovieDetail(apiKey, imdbID);
  }

  @override
  Future<SearchResult> searchMovies(String apiKey, String query) {
    return _api.searchMovies(apiKey, query);
  }

  @override
  Future<void> deleteBookmarkByID(String imdbID) {
    return _dao.deleteBookmarkByID(imdbID);
  }
}
