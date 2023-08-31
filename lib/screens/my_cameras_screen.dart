import 'package:flutter/material.dart';

class CamerasScreen extends StatelessWidget {
  const CamerasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cameras'),
      ),
      body: const Center(
        child: Text('Cameras Screen Content'),
      ),
    );
  }
}
