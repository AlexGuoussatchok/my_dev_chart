import 'package:flutter/material.dart';
import 'my_cameras_screen.dart';
import 'my_lenses_screen.dart';
import 'my_films_screen.dart';
import 'package:my_dev_chart/databases/my_films_database_helper.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to CamerasScreen (You'll need to create this screen)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CamerasScreen()),
                );
              },
              child: const Text(
                'Cameras',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Navigate to LensesScreen (You'll need to create this screen)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LensesScreen()),
                );
              },
              child: const Text(
                'Lenses',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Set the background color
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () async {
                final BuildContext currentContext = context;
                final myFilmsHelper = MyFilmsDatabaseHelper.instance;

                await myFilmsHelper.initializeDatabase();

                Navigator.push(
                  currentContext,
                  MaterialPageRoute(builder: (context) => const FilmsScreen()),
                );
              },
              child: const Text(
                'Films',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
