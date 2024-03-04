import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingfo_movies/features/domain/usecase/delete_all_bookmark_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/get_all_bookmark_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/insert_bookmark_usecase.dart';
import 'package:ingfo_movies/features/domain/usecase/remove_bookmark_usecase.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/bookmark_event.dart';
import 'package:ingfo_movies/features/presentation/blocs/bookmark/boomark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final InsertBookmarkUseCase insertBookmarkUseCase;
  final RemoveBookmarkUseCase removeBookmarkUseCase;
  final GetAllBookmarkUseCase getAllBookmarkUseCase;
  final DeleteAllBookmarkUseCase deleteAllBookmarkUseCase;

  BookmarkBloc(
    this.getAllBookmarkUseCase,
    this.insertBookmarkUseCase,
    this.removeBookmarkUseCase,
    this.deleteAllBookmarkUseCase,
  ) : super(const BookmarkLoadingState()) {
    on<GetAllBookmarkEvent>(onGetAllBookmark);
    on<AddMovieToBookmarkEvent>(onAddBookmark);
    on<RemoveMovieFromBookmarkEvent>(onRemoveBookmark);
    on<CheckBookmarkEvent>(onCheckBookmark);
    on<DeleteAllBookmarkEvent>(onDeleteAllBookmark);
    on<CheckAllBookmarksEvent>(onCheckAllBookmarks);
  }

  void onGetAllBookmark(
    GetAllBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const BookmarkLoadingState());
    final bookmarks = await getAllBookmarkUseCase();
    emit(BookmarkSuccessState(bookmarks));
  }

  void onRemoveBookmark(
    RemoveMovieFromBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    await removeBookmarkUseCase(params: RemoveBookmarkParams(event.imdbID!));
    final currentBookmarks = await getAllBookmarkUseCase();
    emit(const BookmarkLoadingState());
    emit(BookmarkSuccessState(currentBookmarks));
    add(CheckBookmarkEvent(event.imdbID!));
  }

  void onAddBookmark(
    AddMovieToBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    await insertBookmarkUseCase(params: event.bookmark);
    final currentBookmarks = await getAllBookmarkUseCase();
    emit(BookmarkSuccessState(currentBookmarks));
    add(CheckBookmarkEvent(event.bookmark!.imdbID));
  }

  void onCheckBookmark(
    CheckBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    final allBookmarks = await getAllBookmarkUseCase();
    final isBookmarked =
        allBookmarks.any((bookmark) => bookmark.imdbID == event.imdbID);
    if (isBookmarked) {
      emit(const BookmarkBookmarkedState());
    } else {
      emit(const BookmarkNotBookmarkedState());
    }
  }

  void onDeleteAllBookmark(
    DeleteAllBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    await deleteAllBookmarkUseCase();
    add(const CheckAllBookmarksEvent()); // Mengecek status semua bookmark
  }

  void onCheckAllBookmarks(
    CheckAllBookmarksEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    final allBookmarks = await getAllBookmarkUseCase();
    if (allBookmarks.isNotEmpty) {
      emit(BookmarkSuccessState(allBookmarks));
    } else {
      emit(const BookmarkEmptyState()); // Menampilkan bahwa tidak ada bookmark
    }
  }
}
