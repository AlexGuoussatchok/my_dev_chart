import 'package:flutter/material.dart';
import 'darkroom_screen.dart';
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Customize button color here
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to Inventory
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InventoryScreen()),
                );
              },
              child: const Text(
                'Inventory',
                style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
              ),
            ),
            const SizedBox(height: 16), // Add vertical spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Customize button color here
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to Catalogue
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CatalogueScreen()),
                );
              },
              child: const Text(
                'Catalogue',
                style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
              ),
            ),
            const SizedBox(height: 16), // Add vertical spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to DarkroomScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DarkroomScreen()),
                );
              },
              child: const Text(
                'Darkroom',
                style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
              ),
            ),
          ],
        ),
      ),
    );
  }
}
