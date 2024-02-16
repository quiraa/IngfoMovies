import 'package:floor/floor.dart';

@Entity(tableName: 'bookmark')
class Bookmark {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int id;

  final String title;
  final String released;
  final String photoUrl;
  final String imdbID;

  Bookmark(
    this.id,
    this.title,
    this.photoUrl,
    this.released,
    this.imdbID,
  );
}
