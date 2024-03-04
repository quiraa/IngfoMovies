import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ingfo_movies/core/constants/constants.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository.dart';
import 'package:ingfo_movies/features/data/repository/movie_repository_impl.dart';
import 'package:ingfo_movies/features/data/source/api/api_service.dart';
import 'package:ingfo_movies/features/data/source/database/movie_database.dart';
import 'package:ingfo_movies/features/domain/usecase/delete_all_bookmark_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/get_all_bookmark_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/get_detail_movie_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/insert_bookmark_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/remove_bookmark_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/search_movie_usecase.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/bookmark_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/detail/detail_bloc.dart';
import 'package:ingfo_movies/features/presentation/blocs/home/home_bloc.dart';

final injection = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorMovieDatabase.databaseBuilder(Constants.databaseName).build();

  injection.registerSingleton<MovieDatabase>(database);

  injection.registerSingleton<Dio>(Dio());

  // * Services
  injection.registerSingleton<ApiService>(
    ApiService(injection()),
  );

  injection.registerSingleton<MovieRepository>(
    MovieRepositoryImpl(injection(), injection()),
  );

  // * Use Cases

  injection.registerSingleton<SearchMovieUseCase>(
    SearchMovieUseCase(injection()),
  );

  injection.registerSingleton<GetDetailMovieUseCase>(
    GetDetailMovieUseCase(injection()),
  );

  injection.registerSingleton<InsertBookmarkUseCase>(
    InsertBookmarkUseCase(injection()),
  );

  injection.registerSingleton<RemoveBookmarkUseCase>(
    RemoveBookmarkUseCase(injection()),
  );

  injection.registerSingleton<GetAllBookmarkUseCase>(
    GetAllBookmarkUseCase(injection()),
  );

  injection.registerSingleton<DeleteAllBookmarkUseCase>(
    DeleteAllBookmarkUseCase(injection()),
  );

  // * BLoC

  injection.registerFactory<HomeBloc>(
    () => HomeBloc(injection()),
  );

  injection.registerFactory<DetailBloc>(
    () => DetailBloc(injection()),
  );

  injection.registerFactory<BookmarkBloc>(
    () => BookmarkBloc(
      injection(),
      injection(),
      injection(),
      injection(),
    ),
  );
}
