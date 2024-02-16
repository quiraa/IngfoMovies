import 'package:floor/floor.dart';

@Entity(tableName: 'bookmark')
class Bookmark {
  @PrimaryKey()
  @ColumnInfo(name: 'id')
  final String imdbID;

  @ColumnInfo(name: 'title')
  final String title;

  @ColumnInfo(name: 'released')
  final String released;

  @ColumnInfo(name: 'photoUrl')
  final String photoUrl;

  Bookmark(
    this.imdbID,
    this.title,
    this.photoUrl,
    this.released,
  );
}
