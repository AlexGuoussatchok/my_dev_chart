import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/database_helper.dart';
import 'package:my_dev_chart/extra_classes/record_class.dart';
import 'package:my_dev_chart/screens/record_details_screen.dart'; // Import the new details screen

class BrowseRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Records'),
      ),
      body: FutureBuilder<List<RecordClass>>(
        future: DatabaseHelper().getRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No records found.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final record = snapshot.data![index];

                return ListTile(
                  title: Text('Film Number: ${record.filmNumber}'),
                  subtitle: Text('Date: ${record.date.toString()}\nFilm: ${record.film}\nISO: ${record.selectedIso}\nDeveloper: ${record.developer}'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecordDetailsScreen(record),
                    ));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
