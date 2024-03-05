import 'package:floor/floor.dart';
import 'package:ingfo_movies/features/data/models/entity/bookmark_entity.dart';
import 'package:ingfo_movies/features/data/source/database/movie_dao.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'movie_database.g.dart';

@Database(version: 1, entities: [BookmarkEntity])
abstract class MovieDatabase extends FloorDatabase {
  MovieDao get dao;
}
