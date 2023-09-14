import 'package:flutter/material.dart';
import 'add_my_cameras_record_screen.dart';

class CamerasScreen extends StatelessWidget {
  const CamerasScreen({Key? key}) : super(key: key);

  // Function to handle the menu item selection
  void _handleMenuItemClick(BuildContext context, String value) {
    if (value == 'add_camera') {
      // Navigate to the AddMyCamerasRecordScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AddMyCamerasRecordScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cameras'),
        actions: <Widget>[
          // Add a PopupMenuButton
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuItemClick(context, value), // Pass the context
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add_camera',
                  child: Text('Add a camera to your collection'),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Cameras Screen Content'),
      ),
    );
  }
}
