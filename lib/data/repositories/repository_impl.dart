import 'package:flutter_api/data/repositories/repository.dart';
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
    // TODO: implement addToBookmark
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFromBookmark(Bookmark bookmark) {
    // TODO: implement deleteFromBookmark
    throw UnimplementedError();
  }

  @override
  Future<List<Bookmark>> getAllBookmark() {
    // TODO: implement getAllBookmark
    throw UnimplementedError();
  }

  @override
  Future<List<Bookmark>> getAllBookmarks() {
    // TODO: implement getAllBookmarks
    throw UnimplementedError();
  }

  @override
  Future<DetailMovie> getMovieDetail(String apiKey, String imdbID) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<SearchResult> searchMovies(String apiKey, String query) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}
