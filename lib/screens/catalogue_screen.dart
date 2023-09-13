import 'package:flutter/material.dart';
import 'package:my_dev_chart/screens/cameras_catalogue_screen.dart';
import 'package:my_dev_chart/screens/lenses_catalogue_screen.dart';
import 'package:my_dev_chart/screens/films_catalogue_screen.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
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
                // Navigate to Cameras Catalogue
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CamerasCatalogueScreen()),
                );
              },
              child: const Text(
                'Cameras Catalogue',
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
                // Navigate to Lenses Catalogue
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LensesCatalogueScreen()),
                );
              },
              child: const Text(
                'Lenses Catalogue',
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
                // Navigate to Films Catalogue
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FilmsCatalogueScreen()),
                );
              },
              child: const Text(
                'Films Catalogue',
                style: TextStyle(fontSize: 20 * 1.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
