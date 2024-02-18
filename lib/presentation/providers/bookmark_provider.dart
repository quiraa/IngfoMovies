import 'package:flutter/material.dart';
import 'package:flutter_api/data/source/db/bookmark_database.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';

class BookmarkProvider extends ChangeNotifier {
  List<Bookmark> _bookmarks = [];
  List<Bookmark> get bookmarks => _bookmarks;

  Future<BookmarkDatabase> _createDatabase() async {
    return await $FloorBookmarkDatabase
        .databaseBuilder('bookmark_database.db')
        .build();
  }

  Future<void> getAllBookmark() async {
    final db = await _createDatabase();
    final allBookmark = await db.dao.getAllBookmarks();
    if (allBookmark.isNotEmpty) {
      _bookmarks = allBookmark;
      notifyListeners();
    } else {
      _bookmarks = [];
      notifyListeners();
    }
  }

  Future<void> addToBookmark(Bookmark bookmark) async {
    final db = await _createDatabase();
    final addedBookmark = await db.dao.addToBookmark(bookmark);
    notifyListeners();
    return addedBookmark;
  }

  Future<void> deleteBookmarkByID(String id) async {
    final db = await _createDatabase();
    final deletedBookmark = await db.dao.deleteBookmarkByID(id);
    notifyListeners();
    return deletedBookmark;
  }

  Future<void> deleteAllBookmark() async {
    final db = await _createDatabase();
    await db.dao.deleteAllBookmark();
    _bookmarks.clear();
    notifyListeners();
  }

  Future<bool> isMovieBookmarked(String imdbID) async {
    final db = await _createDatabase();
    final allBookmark = await db.dao.getAllBookmarks();
    final isBookmarked =
        allBookmark.any((bookmark) => bookmark.imdbID == imdbID);
    return isBookmarked;
  }
}
