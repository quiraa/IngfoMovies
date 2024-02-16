import 'package:json_annotation/json_annotation.dart';
part 'search_item.g.dart';

@JsonSerializable()
class SearchItem {
  final String Title;
  final String Year;
  final String imdbID;
  final String Type;
  final String Poster;

  SearchItem({
    required this.Title,
    required this.Year,
    required this.imdbID,
    required this.Type,
    required this.Poster,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) =>
      _$SearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchItemToJson(this);
}
