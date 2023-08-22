import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'browse_records_screen.dart';
import 'add_a_new_record_screen.dart';
import 'statistics_screen.dart';
import 'package:file_picker/file_picker.dart';

class MyDevNotesScreen extends StatefulWidget {
  const MyDevNotesScreen({Key? key}) : super(key: key);

  @override
  _MyDevNotesScreenState createState() => _MyDevNotesScreenState();
}

class _MyDevNotesScreenState extends State<MyDevNotesScreen> {
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    printAppDocumentsDirectory();
  }

  Future<void> printAppDocumentsDirectory() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    print('App Documents Directory: ${appDocDir.path}');
  }

  Future<void> exportDatabase(BuildContext context) async {
    // Request external storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      // Handle the case where permission is denied
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permission Denied'),
          content: Text('Permission denied for exporting.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
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
      String exportPath = '${appDocDir.path}/my_dev_notes_export.db';

      // Export the database to the specified location.
      await File(exportPath).writeAsBytes(await dbHelper.exportDatabaseBytes());

      // Show a success message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Export Successful'),
          content: Text('The database was exported successfully to Documents folder.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      // Handle errors here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Export Error'),
          content: Text('An error occurred while exporting the database: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  Future<void> importDatabase(BuildContext context) async {
    try {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        // Handle the case where permission is denied
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Permission Denied'),
            content: Text('Permission denied for importing.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        final sourceFile = File(result.files.single.path!);

        await dbHelper.importDatabase(sourceFile.path);

        // Show a success message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Import Successful'),
            content: Text('The database was imported successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle any errors that occur during import
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Import Error'),
          content: Text('An error occurred while importing the database: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Dev Notes'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'export') {
                exportDatabase(context);
              } else if (value == 'import') {
                importDatabase(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'export',
                  child: Text('Export database'),
                ),
                PopupMenuItem<String>(
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
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowseRecordsScreen(dbHelper: dbHelper)), // Pass dbHelper here
                );
              },
              child: Text(
                'Browse records',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewRecordScreen(dbHelper: dbHelper)), // Pass dbHelper here
                );
              },
              child: Text(
                'Add a new record',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsScreen(dbHelper: dbHelper)), // Pass dbHelper here
                );
              },
              child: Text(
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
