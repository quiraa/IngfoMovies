import 'package:dio/dio.dart';
import 'package:flutter_api/domain/models/detail/detail_movie.dart';
import 'package:flutter_api/domain/models/search/search_result.dart';
import 'package:flutter_api/presentation/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
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
