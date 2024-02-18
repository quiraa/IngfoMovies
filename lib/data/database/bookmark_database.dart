import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_api/data/database/bookmark_dao.dart';
import 'package:flutter_api/domain/entities/bookmark.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'bookmark_database.g.dart';

@Database(version: 1, entities: [Bookmark])
abstract class BookmarkDatabase extends FloorDatabase {
  BookmarkDao get dao;
}
