import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyFilmsDatabaseHelper {
  static final MyFilmsDatabaseHelper instance =
  MyFilmsDatabaseHelper._privateConstructor();

  // Private constructor
  MyFilmsDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_films.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_films (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filmName TEXT NOT NULL
      )
    ''');
  }

  Future<void> initializeDatabase() async {
    final db = await database;
    // You can perform any additional database initialization here if needed
  }

  Future<List<String>> getFilmNames() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('films_catalogue'); // Adjust the table name if needed

    return List.generate(maps.length, (i) {
      return '${maps[i]['brand']} - ${maps[i]['film_name']}';
    });
  }

}
