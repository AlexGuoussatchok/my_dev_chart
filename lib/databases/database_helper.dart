import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_dev_chart/extra_classes/record_class.dart';

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
    String dbName = 'films_$year.db';
    String path = join(databasesPath, dbName);

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS films_$year (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          filmNumber TEXT,
          date TEXT,
          film TEXT,
          selectedIso TEXT,
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

  Future<void> insertFilm(Map<String, dynamic> filmData) async {
    final db = await database;
    await db.insert('films_2023', filmData);
  }

  Future<List<RecordClass>> getRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('films_2023');

    return List.generate(maps.length, (index) {
      return RecordClass(
        filmNumber: int.parse(maps[index]['filmNumber']),
        date: DateTime.parse(maps[index]['date']),
        film: maps[index]['film'],
        selectedIso: maps[index]['selectedIso'],
        filmType: maps[index]['filmType'],
        camera: maps[index]['camera'],
        lenses: maps[index]['lenses'],
        developer: maps[index]['developer'],
        dilution: maps[index]['dilution'],
        developingTime: maps[index]['developingTime'],
        temperature: double.parse(maps[index]['temperature'].toString()),
        comments: maps[index]['comments'],
      );
    });
  }
}
