import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:my_dev_chart/extra_classes/my_films.dart';

class InventoryDatabaseHelper {
  static Database? _database;

  Future<void> initialize() async {
    if (_database == null) {
      final path = join(await getDatabasesPath(), 'inventory.db');
      print('Database path: $path');

      bool databaseExists = await File(path).exists();

      if (!databaseExists) {
        print('Database does not exist. Creating...');
        _database = await openDatabase(
          path,
          version: 1,
          onConfigure: (db) {
            db.execute('PRAGMA foreign_keys = ON');
          },
          onCreate: (db, version) async {
            // Create your tables here
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
        print('Database exists. Opening...');
        _database = await openDatabase(path);
      }
    }
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      print('Database closed.');
    }
  }

  static Future<List<MyFilms>> getAllFilms() async {
    final dbHelper = InventoryDatabaseHelper(); // Create an instance
    await dbHelper.initialize(); // Initialize the database

    final db = _database;

    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query('my_films');

      return List.generate(maps.length, (i) {
        return MyFilms(
          id: maps[i]['id'],
          brand: maps[i]['brand'],
          film: maps[i]['film'],
          filmType: maps[i]['filmType'],
          filmSize: maps[i]['filmSize'],
          filmIso: maps[i]['filmIso'],
          framesNumber: maps[i]['framesNumber'],
          expirationDate: maps[i]['expirationDate'],
          quantity: maps[i]['quantity'].toString(),
        );
      });
    } else {
      return [];
    }
  }


  Future<void> insertFilm(MyFilms film) async {
    try {
      final db = _database;

      if (db != null) {
        await db.insert('my_films', film.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        print('Film inserted successfully: $film');
      } else {
        // Handle the case where the database is not initialized yet
        throw Exception('Database is not initialized');
      }
    } catch (e) {
      print('Error inserting film: $e');
    }
  }



// Rest of your database methods here...
}
