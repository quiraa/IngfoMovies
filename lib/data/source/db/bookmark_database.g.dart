// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorBookmarkDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$BookmarkDatabaseBuilder databaseBuilder(String name) =>
      _$BookmarkDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$BookmarkDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$BookmarkDatabaseBuilder(null);
}

class _$BookmarkDatabaseBuilder {
  _$BookmarkDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$BookmarkDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$BookmarkDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<BookmarkDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$BookmarkDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$BookmarkDatabase extends BookmarkDatabase {
  _$BookmarkDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookmarkDao? _daoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `bookmark` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `released` TEXT NOT NULL, `photoUrl` TEXT NOT NULL, `imdbID` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BookmarkDao get dao {
    return _daoInstance ??= _$BookmarkDao(database, changeListener);
  }
}

class _$BookmarkDao extends BookmarkDao {
  _$BookmarkDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookmarkInsertionAdapter = InsertionAdapter(
            database,
            'bookmark',
            (Bookmark item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'released': item.released,
                  'photoUrl': item.photoUrl,
                  'imdbID': item.imdbID
                }),
        _bookmarkDeletionAdapter = DeletionAdapter(
            database,
            'bookmark',
            ['id'],
            (Bookmark item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'released': item.released,
                  'photoUrl': item.photoUrl,
                  'imdbID': item.imdbID
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Bookmark> _bookmarkInsertionAdapter;

  final DeletionAdapter<Bookmark> _bookmarkDeletionAdapter;

  @override
  Future<List<Bookmark>> getAllBookmarks() async {
    return _queryAdapter.queryList('SELECT * FROM bookmark ORDER BY title ASC',
        mapper: (Map<String, Object?> row) => Bookmark(
            row['id'] as int,
            row['title'] as String,
            row['photoUrl'] as String,
            row['released'] as String,
            row['imdbID'] as String));
  }

  @override
  Future<void> deleteAllBookmark() async {
    await _queryAdapter.queryNoReturn('DELETE FROM bookmark');
  }

  @override
  Future<void> addToBookmark(Bookmark bookmark) async {
    await _bookmarkInsertionAdapter.insert(
        bookmark, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteFromBookmark(Bookmark bookmark) async {
    await _bookmarkDeletionAdapter.delete(bookmark);
  }
}
