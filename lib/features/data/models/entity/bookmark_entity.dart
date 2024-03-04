import 'package:floor/floor.dart';

@Entity(tableName: 'bookmark')
class BookmarkEntity {
  @PrimaryKey()
  @ColumnInfo(name: 'id')
  final String imdbID;

  @ColumnInfo(name: 'title')
  final String title;

  @ColumnInfo(name: 'released')
  final String released;

  @ColumnInfo(name: 'photoUrl')
  final String photoUrl;

  BookmarkEntity(
    this.imdbID,
    this.title,
    this.photoUrl,
    this.released,
  );
}
