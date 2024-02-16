import 'package:flutter_api/domain/models/detail/movie_rating.dart';
import 'package:json_annotation/json_annotation.dart';
part 'detail_movie.g.dart';

@JsonSerializable()
class DetailMovie {
  final String? Title;
  final String? Year;
  final String? Rated;
  final String? Released;
  final String? Runtime;
  final String? Genre;
  final String? Director;
  final String? Writer;
  final String? Actors;
  final String? Plot;
  final String? Language;
  final String? Country;
  final String? Awards;
  final String? Poster;
  final List<MovieRating>? Ratings;
  final String? Metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? imdbID;
  final String? Type;
  final String? DVD;
  final String? BoxOffice;
  final String? Production;
  final String? Website;
  final String? Response;
  final String? totalSeasons;

  DetailMovie({
    this.Title,
    this.Year,
    this.Rated,
    this.Released,
    this.Runtime,
    this.Genre,
    this.Director,
    this.Writer,
    this.Actors,
    this.Plot,
    this.Language,
    this.Country,
    this.Awards,
    this.Poster,
    this.Ratings,
    this.Metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbID,
    this.Type,
    this.DVD,
    this.BoxOffice,
    this.Production,
    this.Website,
    this.Response,
    this.totalSeasons,
  });

  factory DetailMovie.fromJson(Map<String, dynamic> json) =>
      _$DetailMovieFromJson(json);
  Map<String, dynamic> toJson() => _$DetailMovieToJson(this);
}
