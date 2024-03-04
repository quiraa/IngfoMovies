import 'package:json_annotation/json_annotation.dart';

part 'search_result_item.g.dart';

@JsonSerializable()
class SearchResultItem {
  final String? Title;
  final String? Year;
  final String? imdbID;
  final String? Type;
  final String? Poster;

  SearchResultItem({
    this.Title,
    this.Year,
    this.imdbID,
    this.Type,
    this.Poster,
  });

  factory SearchResultItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResultItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultItemToJson(this);
}
