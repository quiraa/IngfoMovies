import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';

abstract class BookmarkEvent {
  final BookmarkEntity? bookmark;
  final String? imdbID;
  const BookmarkEvent({this.bookmark, this.imdbID});
}

class GetAllBookmarkEvent extends BookmarkEvent {
  const GetAllBookmarkEvent();
}

class AddMovieToBookmarkEvent extends BookmarkEvent {
  const AddMovieToBookmarkEvent(BookmarkEntity bookmark)
      : super(bookmark: bookmark);
}

class DeleteAllBookmarkEvent extends BookmarkEvent {
  const DeleteAllBookmarkEvent();
}

class RemoveMovieFromBookmarkEvent extends BookmarkEvent {
  const RemoveMovieFromBookmarkEvent(String imdbID) : super(imdbID: imdbID);
}

class CheckBookmarkEvent extends BookmarkEvent {
  const CheckBookmarkEvent(String imdbID) : super(imdbID: imdbID);
}

class CheckAllBookmarksEvent extends BookmarkEvent {
  const CheckAllBookmarksEvent();
}
