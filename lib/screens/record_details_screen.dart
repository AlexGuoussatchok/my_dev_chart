import 'package:flutter/material.dart';
import 'package:my_dev_chart/extra_classes/record_class.dart';
import 'package:my_dev_chart/databases/database_helper.dart';
import 'package:my_dev_chart/screens/edit_record_screen.dart';

class RecordDetailsScreen extends StatelessWidget {
  final RecordClass record;

  RecordDetailsScreen(this.record);

  Future<void> _deleteRecord(BuildContext context) async {
    await DatabaseHelper().deleteRecord(record.filmNumber); // Assuming filmNumber is unique
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _deleteRecord(context);
              } else if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditRecordScreen(record),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit Record'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete Record'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Film Number: ${record.filmNumber}'),
            Text('Date: ${record.date.toString()}'),
            Text('Film: ${record.film}'),
            Text('ISO: ${record.selectedIso}'),
            Text('Film Type: ${record.filmType}'),
            Text('Camera: ${record.camera ?? 'N/A'}'),
            Text('Lenses: ${record.lenses ?? 'N/A'}'),
            Text('Developer: ${record.developer}'),
            Text('Dilution: ${record.dilution}'),
            Text('Developing Time: ${record.developingTime ?? 'N/A'}'),
            Text('Temperature: ${record.temperature.toString()} °C'),
            Text('Comments: ${record.comments ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
