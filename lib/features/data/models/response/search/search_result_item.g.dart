// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultItem _$SearchResultItemFromJson(Map<String, dynamic> json) =>
    SearchResultItem(
      Title: json['Title'] as String?,
      Year: json['Year'] as String?,
      imdbID: json['imdbID'] as String?,
      Type: json['Type'] as String?,
      Poster: json['Poster'] as String?,
    );

Map<String, dynamic> _$SearchResultItemToJson(SearchResultItem instance) =>
    <String, dynamic>{
      'Title': instance.Title,
      'Year': instance.Year,
      'imdbID': instance.imdbID,
      'Type': instance.Type,
      'Poster': instance.Poster,
    };
