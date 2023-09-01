import 'package:flutter/material.dart';
import 'package:my_dev_chart/screens/my_dev_notes_screen.dart';
import 'dev_chart_screen.dart';
import 'my_dev_chart_screen.dart';

class DarkroomScreen extends StatelessWidget {
  const DarkroomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Darkroom'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Customize button color here
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to DevChartScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DevChartScreen()),
                );
              },
              child: const Text('Dev Chart', style: TextStyle(fontSize: 20 * 1.7)),
            ),
            const SizedBox(height: 16), // Add vertical spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Customize button color here
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to MyDevChartScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyDevChartScreen()),
                );
              },
              child: const Text('My Dev Chart', style: TextStyle(fontSize: 20 * 1.7)),
            ),
            const SizedBox(height: 16), // Add vertical spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Customize button color here
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to MyDevNotesScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyDevNotesScreen()),
                );
              },
              child: const Text('My Dev Notes', style: TextStyle(fontSize: 20 * 1.7)),
            ),
          ],
        ),
      ),
    );
  }
}
