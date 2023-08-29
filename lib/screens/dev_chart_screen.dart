import 'package:flutter/material.dart';

class DevChartScreen extends StatelessWidget {
  const DevChartScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Chart'),
      ),
      body: const Center(
        child: Text('Dev Chart Screen Content'),
      ),
    );
  }
}
