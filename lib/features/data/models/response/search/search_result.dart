import 'package:ingfo_movies/features/data/models/response/search/search_result_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  final List<SearchResultItem>? Search;
  final String? totalResults;
  final String? Response;

  SearchResult({
    this.Search,
    this.totalResults,
    this.Response,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
