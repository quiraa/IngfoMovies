import 'package:json_annotation/json_annotation.dart';
part 'movie_rating.g.dart';

@JsonSerializable()
class MovieRating {
  final String Source;
  final String Value;

  MovieRating({
    required this.Source,
    required this.Value,
  });

  factory MovieRating.fromJson(Map<String, dynamic> json) =>
      _$MovieRatingFromJson(json);
  Map<String, dynamic> toJson() => _$MovieRatingToJson(this);
}
