import 'package:flutter/material.dart';
import 'browse_records_screen.dart'; // Import the BrowseRecordsScreen class
import 'add_a_new_record_screen.dart'; // Import the AddNewRecordScreen class
import 'statistics_screen.dart'; // Import the StatisticsScreen class

class MyDevNotesScreen extends StatelessWidget {
  const MyDevNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Dev Notes'),
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
                // Navigate to BrowseRecordsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowseRecordsScreen()),
                );
              },
              child: Text(
                'Browse records',
                style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
              ),
            ),
            SizedBox(height: 16), // Add spacing between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to AddNewRecordScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewRecordScreen()),
                );
              },
              child: Text(
                'Add a new record',
                style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
              ),
            ),
            SizedBox(height: 16), // Add spacing between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to StatisticsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsScreen()),
                );
              },
              child: Text(
                'Statistics',
                style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
              ),
            ),
          ],
        ),
      ),
    );
  }
}
