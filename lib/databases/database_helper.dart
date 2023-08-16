import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String year = "2023"; // Extract year from selectedDate or use a default year
    String path = join(databasesPath, 'films_$year.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS films_$year(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          filmNumber TEXT,
          date TEXT,
          iso TEXT,
          filmType TEXT,
          camera TEXT,
          lenses TEXT,
          developer TEXT,
          dilution TEXT,
          developingTime TEXT,
          temperature REAL,
          comments TEXT
        )
      ''');
    });
  }

  Future<void> insertFilm(Map<String, dynamic> filmData, int year) async {
    final db = await database;
    await db.insert('films_$year', filmData);
  }
}
