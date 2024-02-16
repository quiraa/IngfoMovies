import 'package:flutter_api/data/source/api/api_service.dart';
import 'package:flutter_api/data/source/db/bookmark_dao.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';
import 'package:flutter_api/domain/models/detail/detail_movie.dart';
import 'package:flutter_api/domain/models/search/search_result.dart';

class Repository {
  final BookmarkDao _dao;
  final ApiService _api;

  Repository({required BookmarkDao dao, required ApiService api})
      : _dao = dao,
        _api = api;

  Future<List<Bookmark>> getAllBookmark() async {
    return _dao.getAllBookmarks();
  }

  Future<List<Bookmark>> getAllBookmarks() async {
    return _dao.getAllBookmarks();
  }

  Future<void> addToBookmark(Bookmark bookmark) async {
    return _dao.addToBookmark(bookmark);
  }

  Future<void> deleteFromBookmark(Bookmark bookmark) async {
    return _dao.deleteFromBookmark(bookmark);
  }

  Future<SearchResult> searchMovies(String apiKey, String query) async {
    return _api.searchMovies(apiKey, query);
  }

  Future<DetailMovie> getMovieDetail(String apiKey, String imdbID) async {
    return _api.getMovieDetail(apiKey, imdbID);
  }
}
