import 'package:floor/floor.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM bookmark ORDER BY title ASC')
  Future<List<BookmarkEntity>> getAllBookmarks();

  @Query('DELETE FROM bookmark')
  Future<void> deleteAllBookmark();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertToBookmark(BookmarkEntity bookmark);

  @Query('DELETE FROM bookmark WHERE id = :id')
  Future<void> removeFromBookmark(String id);
}
