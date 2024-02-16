import 'package:flutter_api/domain/models/search/search_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  final List<SearchItem> Search;
  final String totalResults;
  final String Response;

  SearchResult({
    required this.Search,
    required this.totalResults,
    required this.Response,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
