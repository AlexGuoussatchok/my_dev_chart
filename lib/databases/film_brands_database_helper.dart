import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class FilmBrandsDatabaseHelper {
  // Singleton pattern to ensure only one instance of this helper is created
  static final FilmBrandsDatabaseHelper instance =
  FilmBrandsDatabaseHelper._privateConstructor();
  FilmBrandsDatabaseHelper._privateConstructor();

  // Stores a reference to the database instance
  static Database? _database;

  // Getter for the database instance, creating it if it doesn't exist
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database doesn't exist, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database by opening the pre-created 'film_brands.db' in assets
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'film_brands.db');
    final dbFactory = databaseFactory;

    // Check if the database file exists in the application's database directory
    if (await databaseExists(path)) {
      return dbFactory.openDatabase(path);
    }

    // Database file does not exist, open it from assets
    final ByteData data = await rootBundle.load('assets/film_brands.db');
    final List<int> bytes = data.buffer.asUint8List();
    await File(path).writeAsBytes(bytes);

    return dbFactory.openDatabase(path);
  }

  // Retrieves a list of film brands from the 'film_brands' table
  Future<List<String>> getFilmBrands() async {
    // Get a reference to the database
    final db = await database;

    // Query the 'film_brands' table to retrieve brand names
    final List<Map<String, dynamic>> brandMaps = await db.query('film_brands', columns: ['brand']);

    // Generate a list of brand names from the query results
    return List.generate(brandMaps.length, (index) {
      return brandMaps[index]['brand'] as String;
    });
  }

}
