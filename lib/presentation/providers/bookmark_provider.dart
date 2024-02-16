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
    } else {
      _bookmarks = [];
    }
    notifyListeners();
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
}

// class BookmarkProvider extends ChangeNotifier {
//   final BookmarkDatabase _database;

//   BookmarkProvider(this._database);

//   List<Bookmark> _bookmarks = [];
//   List<Bookmark> get bookmarks => _bookmarks;

//   Future<void> getAllBookmark() async {
//     final allBookmark = await _database.dao.getAllBookmarks();
//     if (allBookmark.isNotEmpty) {
//       _bookmarks = allBookmark;
//     } else {
//       _bookmarks = [];
//     }
//     notifyListeners();
//   }

//   Future<void> addToBookmark(Bookmark bookmark) async {
//     await _database.dao.addToBookmark(bookmark);
//     notifyListeners();
//   }

//   Future<void> deleteBookmarkByID(String imdbID) async {
//     await _database.dao.deleteBookmarkByID(imdbID);
//     notifyListeners();
//   }

//   Future<void> deleteAllBookmark() async {
//     await _database.dao.deleteAllBookmark();
//     _bookmarks.clear();
//     notifyListeners();
//   }
// }
