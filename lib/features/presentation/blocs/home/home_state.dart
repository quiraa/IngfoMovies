import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ingfo_movies/features/data/models/response/search/search_result.dart';

abstract class HomeState extends Equatable {
  final SearchResult? searchResult;
  final DioException? error;

  const HomeState({this.error, this.searchResult});

  @override
  List<Object?> get props => [searchResult!, error!];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeDefaultState extends HomeState {
  const HomeDefaultState();
}

class HomeSuccessState extends HomeState {
  const HomeSuccessState(SearchResult searchResult)
      : super(searchResult: searchResult);
}

class HomeErrorState extends HomeState {
  const HomeErrorState(DioException error) : super(error: error);
}
