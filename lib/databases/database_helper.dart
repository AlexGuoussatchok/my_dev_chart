import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_dev_chart/extra_classes/record_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'my_dev_notes.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS my_dev_notes (
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

  Future<int> getHighestFilmNumber() async {
    final db = await database;
    final result = await db.rawQuery('SELECT MAX(filmNumber) FROM my_dev_notes');
    final maxFilmNumberString = result.first['MAX(filmNumber)'] as String?;
    int? highestFilmNumber =
    maxFilmNumberString != null ? int.tryParse(maxFilmNumberString) : null;
    return highestFilmNumber ?? 0;
  }

  Future<void> insertFilm(Map<String, dynamic> filmData) async {
    final db = await database;

    final existingRecords = await db.query(
      'my_dev_notes',
      where: 'filmNumber = ?',
      whereArgs: [filmData['filmNumber']],
    );

    if (existingRecords.isNotEmpty) {
      // Film number already exists, handle accordingly (show error, etc.)
      return;
    }

    await db.insert('my_dev_notes', filmData);
  }

  Future<void> updateRecord(Map<String, dynamic> updatedData) async {
    final db = await database;

    await db.update(
      'my_dev_notes',
      updatedData,
      where: 'filmNumber = ?',
      whereArgs: [updatedData['filmNumber']],
    );
  }

  Future<void> deleteRecord(String filmNumber) async {
    final db = await database;

    await db.delete(
      'my_dev_notes',
      where: 'filmNumber = ?',
      whereArgs: [filmNumber],
    );
  }

  Future<List<RecordClass>> getRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('my_dev_notes');

    return List.generate(maps.length, (index) {
      return RecordClass(
        filmNumber: maps[index]['filmNumber'].toString(),
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

  // Export the database to a specified location
  Future<List<int>> exportDatabaseBytes() async {
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String currentDbPath = join(documentsDirectory.path, 'my_dev_notes.db');

        Directory? externalDirectory = await getExternalStorageDirectory();

        if (externalDirectory == null) {
          // Handle the case where external storage is not available
          return [];
        }

        // The Documents folder path on external storage
        String documentsFolderPath = join(externalDirectory.path, 'Documents');

        // Ensure the Documents folder exists
        await Directory(documentsFolderPath).create(recursive: true);

        String exportFileName = 'my_dev_notes.db';
        String exportDbPath = join(documentsFolderPath, exportFileName);

        if (await File(currentDbPath).exists()) {
          await File(currentDbPath).copy(exportDbPath);
          print('Database exported successfully to: $exportDbPath');

          // Read the exported file as bytes and return them
          final bytes = await File(exportDbPath).readAsBytes();
          return bytes;
        } else {
          // Handle the case where the database file doesn't exist
          return [];
        }
      } else {
        // Handle the case where permission is denied
        print('Permission denied for exporting');
        return [];
      }
    } catch (error) {
      print('Export Error: $error');
      return [];
    }
  }


  Future<void> importDatabase(String filePath) async {
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String currentDbPath = join(documentsDirectory.path, 'my_dev_notes.db');

        // Copy the imported database file to the app's document directory
        await File(filePath).copy(currentDbPath);

        print('Database imported successfully');
      } else {
        // Handle the case where permission is denied
        print('Permission denied for importing');
      }
    } catch (error) {
      print('Import Error: $error');
    }
  }


}
