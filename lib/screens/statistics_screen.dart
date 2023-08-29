import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/database_helper.dart'; // Import your dbHelper

class StatisticsScreen extends StatefulWidget {
  final DatabaseHelper dbHelper; // Add this line to receive dbHelper

  const StatisticsScreen({Key? key, required this.dbHelper}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int totalRecords = 0; // Initialize a variable to hold the statistic

  @override
  void initState() {
    super.initState();
    _loadStatistics(); // Load statistics when the screen initializes
  }

  Future<void> _loadStatistics() async {
    try {
      // Use dbHelper to fetch data from your database
      final records = await widget.dbHelper.getRecords();

      setState(() {
        // Calculate the statistic, for example, the total number of records
        totalRecords = records.length;
      });
    } catch (error) {
      // Handle any errors that occur during data fetching
      print('Error loading statistics: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistics Screen Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Display the statistic
            _buildStatisticItem('Total Records:', totalRecords.toString()),
            // Add more statistics as needed
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
