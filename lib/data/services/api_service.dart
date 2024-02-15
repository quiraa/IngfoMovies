import 'package:dio/dio.dart';
import 'package:flutter_api/data/models/detail/detail_movie.dart';
import 'package:flutter_api/data/models/search/search_result.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://www.omdbapi.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/')
  Future<SearchResult> searchMovies(
    @Query('apiKey') String apiKey,
    @Query('s') String query,
  );

  @GET('/')
  Future<DetailMovie> getMovieDetail(
    @Query('apiKey') String apiKey,
    @Query('i') String imdbID,
  );
}
