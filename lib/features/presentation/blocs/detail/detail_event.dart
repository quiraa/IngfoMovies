abstract class DetailEvent {
  final String? imdbID;

  const DetailEvent({this.imdbID});
}

class GetDetailMovieEvent extends DetailEvent {
  const GetDetailMovieEvent(String imdbID) : super(imdbID: imdbID);
}
