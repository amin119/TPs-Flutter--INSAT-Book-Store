import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'insat_store.db');
    // open database
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS book (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          price INTEGER,
          image TEXT,
          user_email TEXT
        )
      ''');
    });
  }

  Future<void> close() async {
    final dbClient = _db;
    if (dbClient != null) {
      await dbClient.close();
      _db = null;
    }
  }
}
