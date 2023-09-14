import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CamerasCatalogueScreen extends StatefulWidget {
  const CamerasCatalogueScreen({Key? key}) : super(key: key);

  @override
  _CamerasCatalogueScreenState createState() => _CamerasCatalogueScreenState();
}

class _CamerasCatalogueScreenState extends State<CamerasCatalogueScreen> {
  late Database _cameraCatalogueDatabase;
  List<String>? _cameraBrands; // Make _cameraBrands nullable

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      // Open the database from assets directly
      _cameraCatalogueDatabase = await openDatabase('assets/films_catalogue.db');

      // Proceed with querying data as before
      final brands = await _cameraCatalogueDatabase.query('camera_brands', columns: ['camera_brand']);
      final brandList = brands.map((brandMap) => brandMap['camera_brand'].toString()).toList();

      setState(() {
        _cameraBrands = brandList;
      });
    } catch (e) {
      print('Error initializing camera catalogue database: $e');
    }
  }

  @override
  void dispose() {
    _cameraCatalogueDatabase.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cameras Catalogue'),
      ),
      body: _buildCameraList(),
    );
  }

  Widget _buildCameraList() {
    // Check if _cameraBrands is null or empty
    if (_cameraBrands == null || _cameraBrands!.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: _cameraBrands!.length,
      itemBuilder: (context, index) {
        final brand = _cameraBrands![index]; // Use ! to assert it's not null
        return FutureBuilder<List<String>>(
          future: _queryCameraNames(brand),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final cameraNames = snapshot.data ?? [];

              // Build a list of ListTile widgets for camera names
              final cameraListTiles = cameraNames.map((cameraName) {
                return ListTile(
                  title: Text('$brand - $cameraName'),
                  // Add onTap handler if needed
                );
              }).toList();

              return Column(
                children: [
                  ListTile(
                    title: Text('Brand: $brand'),
                  ),
                  ...cameraListTiles,
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }

  Future<List<String>> _queryCameraNames(String brand) async {
    try {
      final tableName = '${brand.toLowerCase()}_cameras_catalogue';

      // Check if the table exists before querying
      bool tableExists = await _cameraCatalogueDatabase
          .rawQuery("SELECT 1 FROM sqlite_master WHERE type='table' AND name='$tableName'")
          .then((value) => value.isNotEmpty);

      if (!tableExists) {
        // Table doesn't exist, return an empty list or handle it accordingly
        print('Table $tableName does not exist.');
        return [];
      }

      final names = await _cameraCatalogueDatabase.query(tableName, columns: ['camera_name']);
      final nameList = names.map((nameMap) => nameMap['camera_name'].toString()).toList();
      return nameList;
    } catch (e) {
      print('Error querying camera names for $brand: $e');
      return [];
    }
  }


}
