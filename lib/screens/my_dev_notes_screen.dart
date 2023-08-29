import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'browse_records_screen.dart';
import 'add_a_new_record_screen.dart';
import 'statistics_screen.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class MyDevNotesScreen extends StatefulWidget {
  const MyDevNotesScreen({Key? key}) : super(key: key);

  @override
  MyDevNotesScreenState createState() => MyDevNotesScreenState();
}

class MyDevNotesScreenState extends State<MyDevNotesScreen> {
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper(); // Initialize dbHelper here
  }

  Future<void> exportDatabase(BuildContext context) async {
    // Capture the context in a local variable
    final localContext = context;

    // Request external storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      // Handle the case where permission is denied
      showDialog(
        context: localContext, // Use the local context here
        builder: (context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Permission denied for exporting.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(localContext), // Use the local context here
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      // Get the app's document directory.
      Directory appDocDir = await getApplicationDocumentsDirectory();

      // Specify the export path in the document directory.
      String exportPath = '${appDocDir.path}/my_dev_notes.db';

      // Export the database to the specified location.
      await File(exportPath).writeAsBytes(await dbHelper.exportDatabaseBytes());

      // Show a success message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Export Successful'),
          content: const Text('The database was exported successfully to the Documents folder.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      // Handle errors here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Export Error'),
          content: Text('An error occurred while exporting the database: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> importDatabase() async {
    try {
      // Request external storage permission
      final status = await Permission.storage.request();
      if (status.isGranted) {
        // Use file picker to select the import source
        final FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null && result.files.isNotEmpty) {
          final PlatformFile file = result.files.first;
          String importFilePath = file.path ?? '';

          // Get the app's document directory where the existing database resides
          Directory documentsDirectory = await getApplicationDocumentsDirectory();
          String currentDbPath = join(documentsDirectory.path, 'my_dev_notes.db');

          if (await File(importFilePath).exists()) {
            // If the imported database file exists, check if the current database file exists
            if (await File(currentDbPath).exists()) {
              // If the current database file exists, delete it to replace with the imported one
              await File(currentDbPath).delete();
            }

            // Copy the imported database file to the app's document directory
            await File(importFilePath).copy(currentDbPath);
            print('Database imported successfully');
          } else {
            // Handle the case where the source file doesn't exist
          }
        }
      } else {
        // Handle the case where permission is denied
        print('Permission denied for importing');
      }
    } catch (error) {
      // Handle any errors that occur during the import process
      print('Import Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dev Notes'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'export') {
                exportDatabase(context); // Pass the context here
              } else if (value == 'import') {
                importDatabase(); // No need to pass the context here
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'export',
                  child: Text('Export database'),
                ),
                const PopupMenuItem<String>(
                  value: 'import',
                  child: Text('Import database'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowseRecordsScreen(dbHelper: dbHelper)), // Pass dbHelper here
                );
              },
              child: const Text(
                'Browse records',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewRecordScreen(dbHelper: dbHelper)), // Pass dbHelper here
                );
              },
              child: const Text(
                'Add a new record',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsScreen(dbHelper: dbHelper)), // Pass dbHelper here
                );
              },
              child: const Text(
                'Statistics',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
