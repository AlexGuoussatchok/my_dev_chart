import 'package:flutter/material.dart';
import 'dev_chart_screen.dart';
import 'my_dev_chart_screen.dart';
import 'my_dev_notes_screen.dart';
import 'catalogue_screen.dart';
import 'inventory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dev Chart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Navigate to DevChartScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DevChartScreen()),
                      );
                    },
                    child: const Text(
                      'Dev Chart',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Navigate to MyDevChartScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyDevChartScreen()),
                      );
                    },
                    child: const Text(
                      'My Dev Chart',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Navigate to MyDevNotesScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyDevNotesScreen()),
                      );
                    },
                    child: const Text(
                      'My Dev Notes',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Customize button color here
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Navigate to Inventory
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InventoryScreen()), // Replace with your InventoryScreen
                      );
                    },
                    child: const Text(
                      'Inventory',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow, // Customize button color here
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Navigate to Catalogue
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CatalogueScreen()), // Replace with your CatalogueScreen
                      );
                    },
                    child: const Text(
                      'Catalogue',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
