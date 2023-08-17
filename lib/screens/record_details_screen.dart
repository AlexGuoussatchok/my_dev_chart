import 'package:flutter/material.dart';
import 'package:my_dev_chart/extra_classes/record_class.dart';

class RecordDetailsScreen extends StatelessWidget {
  final RecordClass record;

  RecordDetailsScreen(this.record);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Film Number: ${record.filmNumber}'),
            Text('Date: ${record.date.toString()}'),
            Text('Film: ${record.film}'),
            Text('ISO: ${record.selectedIso}'),
            Text('Film type: ${record.filmType}'),
            Text('Camera: ${record.camera}'),
            Text('Lenses: ${record.lenses}'),
            Text('Developer: ${record.developer}'),
            Text('Dilution: ${record.dilution}'),
            Text('Developing time: ${record.developingTime}'),
            Text('Temperature: ${record.temperature}'),
            Text('Comments: ${record.comments}'),

            // Add more fields here
          ],
        ),
      ),
    );
  }
}
