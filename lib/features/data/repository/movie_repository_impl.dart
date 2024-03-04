import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ingfo_movies/core/constants/constants.dart';
import 'package:ingfo_movies/core/resources/data_states.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';
import 'package:ingfo_movies/features/data/models/response/detail/detail_movie.dart';
import 'package:ingfo_movies/features/data/models/response/search/search_result.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';
import 'package:ingfo_movies/features/data/source/api/api_service.dart';
import 'package:ingfo_movies/features/data/source/database/movie_database.dart';

class MovieRepositoryImpl implements MovieRepository {
  final ApiService api;
  final MovieDatabase database;

  MovieRepositoryImpl(this.api, this.database);

  @override
  Future<DataState<DetailMovie>> getDetailMovie(String imdbID) async {
    try {
      final searchResponse = await api.getMovieDetail(
        apiKey: Constants.apiKey,
        imdbID: imdbID,
      );

      if (searchResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(searchResponse.data);
      } else {
        return DataError(
          DioException(
            error: searchResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: searchResponse.response,
            requestOptions: searchResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (error) {
      return DataError(error);
    }
  }

  @override
  Future<DataState<SearchResult>> searchMovies(String query) async {
    try {
      final searchResponse = await api.searchMovies(
        apiKey: Constants.apiKey,
        query: query,
      );

      if (searchResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(searchResponse.data);
      } else {
        return DataError(
          DioException(
            error: searchResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: searchResponse.response,
            requestOptions: searchResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (error) {
      return DataError(error);
    }
  }

  @override
  Future<List<BookmarkEntity>> getAllBookmarks() async {
    return database.dao.getAllBookmarks();
  }

  @override
  Future<void> insertToBookmark(
    BookmarkEntity bookmark,
  ) async {
    return database.dao.insertToBookmark(bookmark);
  }

  @override
  Future<void> removeFromBookmark(String imdbID) async {
    return database.dao.removeFromBookmark(imdbID);
  }

  @override
  Future<void> deleteAllBookmark() {
    return database.dao.deleteAllBookmark();
  }
}
