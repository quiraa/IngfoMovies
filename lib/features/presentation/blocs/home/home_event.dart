abstract class HomeEvent {
  final String? query;

  const HomeEvent({this.query});
}

class SearchMovieEvent extends HomeEvent {
  const SearchMovieEvent(String query) : super(query: query);
}
