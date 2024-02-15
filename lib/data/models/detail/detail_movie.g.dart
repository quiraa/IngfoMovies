// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailMovie _$DetailMovieFromJson(Map<String, dynamic> json) => DetailMovie(
      Title: json['Title'] as String?,
      Year: json['Year'] as String?,
      Rated: json['Rated'] as String?,
      Released: json['Released'] as String?,
      Runtime: json['Runtime'] as String?,
      Genre: json['Genre'] as String?,
      Director: json['Director'] as String?,
      Writer: json['Writer'] as String?,
      Actors: json['Actors'] as String?,
      Plot: json['Plot'] as String?,
      Language: json['Language'] as String?,
      Country: json['Country'] as String?,
      Awards: json['Awards'] as String?,
      Poster: json['Poster'] as String?,
      Ratings: (json['Ratings'] as List<dynamic>?)
          ?.map((e) => MovieRating.fromJson(e as Map<String, dynamic>))
          .toList(),
      Metascore: json['Metascore'] as String?,
      imdbRating: json['imdbRating'] as String?,
      imdbVotes: json['imdbVotes'] as String?,
      imdbID: json['imdbID'] as String?,
      Type: json['Type'] as String?,
      DVD: json['DVD'] as String?,
      BoxOffice: json['BoxOffice'] as String?,
      Production: json['Production'] as String?,
      Website: json['Website'] as String?,
      Response: json['Response'] as String?,
      totalSeasons: json['totalSeasons'] as String?,
    );

Map<String, dynamic> _$DetailMovieToJson(DetailMovie instance) =>
    <String, dynamic>{
      'Title': instance.Title,
      'Year': instance.Year,
      'Rated': instance.Rated,
      'Released': instance.Released,
      'Runtime': instance.Runtime,
      'Genre': instance.Genre,
      'Director': instance.Director,
      'Writer': instance.Writer,
      'Actors': instance.Actors,
      'Plot': instance.Plot,
      'Language': instance.Language,
      'Country': instance.Country,
      'Awards': instance.Awards,
      'Poster': instance.Poster,
      'Ratings': instance.Ratings,
      'Metascore': instance.Metascore,
      'imdbRating': instance.imdbRating,
      'imdbVotes': instance.imdbVotes,
      'imdbID': instance.imdbID,
      'Type': instance.Type,
      'DVD': instance.DVD,
      'BoxOffice': instance.BoxOffice,
      'Production': instance.Production,
      'Website': instance.Website,
      'Response': instance.Response,
      'totalSeasons': instance.totalSeasons,
    };
