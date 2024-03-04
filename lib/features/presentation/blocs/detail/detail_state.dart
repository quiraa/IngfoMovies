// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:ingfo_movies/features/data/models/response/detail/detail_movie.dart';

abstract class DetailState extends Equatable {
  final DetailMovie? detailMovie;
  final DioException? error;

  const DetailState({this.detailMovie, this.error});

  @override
  List<Object> get props => [detailMovie!, error!];
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState();
}

class DetailErrorState extends DetailState {
  const DetailErrorState(DioException error) : super(error: error);
}

class DetailSuccessState extends DetailState {
  const DetailSuccessState(DetailMovie detailMovie)
      : super(detailMovie: detailMovie);
}
