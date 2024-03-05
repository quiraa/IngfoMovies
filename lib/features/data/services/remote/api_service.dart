import 'package:dio/dio.dart';
import 'package:ingfo_movies/core/constants/constants.dart';
import 'package:ingfo_movies/features/data/models/response/detail/detail_movie.dart';
import 'package:ingfo_movies/features/data/models/response/search/search_result.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/')
  Future<HttpResponse<SearchResult>> searchMovies({
    @Query('apiKey') String? apiKey,
    @Query('s') String? query,
  });

  @GET('/')
  Future<HttpResponse<DetailMovie>> getMovieDetail({
    @Query('apiKey') String? apiKey,
    @Query('i') String? imdbID,
  });
}
