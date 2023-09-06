import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class InventoryDatabaseHelper {
  late Database _database;

  // Singleton instance
  static final InventoryDatabaseHelper _instance =
  InventoryDatabaseHelper._internal();

  factory InventoryDatabaseHelper() {
    return _instance;
  }

  InventoryDatabaseHelper._internal();

  Future<void> initializeDatabase() async {
    final path = join(await getDatabasesPath(), 'inventory.db');

    bool databaseExists = await File(path).exists();

    if (!databaseExists) {
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          // Create the "my_cameras" table
          await db.execute('''
            CREATE TABLE my_cameras (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              brand TEXT,
              model TEXT,
              serialNumber TEXT,
              cameraType TEXT,
              condition TEXT
            )
          ''');

          // Create the "my_lenses" table
          await db.execute('''
            CREATE TABLE my_lenses (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              brand TEXT,
              model TEXT,
              serialNumber TEXT,
              mount TEXT,
              condition TEXT
            )
          ''');

          // Create the "my_films" table
          await db.execute('''
            CREATE TABLE my_films (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              brand TEXT,
              film TEXT,
              filmType TEXT,
              filmSize TEXT,
              filmIso INTEGER,
              framesNumber INTEGER,
              expirationDate TEXT,
              quantity INTEGER
            )
          ''');
        },
      );
    } else {
      // If it exists, simply open the database
      _database = await openDatabase(path);
    }
  }

// Rest of your database methods here...
}
