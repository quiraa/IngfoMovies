import 'package:floor/floor.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';

@dao
abstract class BookmarkDao {
  @Query('SELECT * FROM bookmark ORDER BY title ASC')
  Future<List<Bookmark>> getAllBookmarks();

  @Query('DELETE FROM bookmark')
  Future<void> deleteAllBookmark();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addToBookmark(Bookmark bookmark);

  @delete
  Future<void> deleteFromBookmark(Bookmark bookmark);
}
