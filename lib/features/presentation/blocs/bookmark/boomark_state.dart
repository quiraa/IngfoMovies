import 'package:equatable/equatable.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';

abstract class BookmarkState extends Equatable {
  final List<BookmarkEntity>? bookmarks;

  const BookmarkState({this.bookmarks});

  @override
  List<Object?> get props => [bookmarks!];
}

class BookmarkLoadingState extends BookmarkState {
  const BookmarkLoadingState();
}

class BookmarkSuccessState extends BookmarkState {
  const BookmarkSuccessState(List<BookmarkEntity> bookmarks)
      : super(bookmarks: bookmarks);
}

class BookmarkBookmarkedState extends BookmarkState {
  const BookmarkBookmarkedState();
}

class BookmarkNotBookmarkedState extends BookmarkState {
  const BookmarkNotBookmarkedState();
}

class BookmarkEmptyState extends BookmarkState {
  const BookmarkEmptyState();
}
