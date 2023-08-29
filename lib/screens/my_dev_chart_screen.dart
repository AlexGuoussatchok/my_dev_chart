import 'package:flutter/material.dart';

class MyDevChartScreen extends StatelessWidget {
  const MyDevChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dev Chart'),
      ),
      body: const Center(
        child: Text('My Dev Chart Screen Content'),
      ),
    );
  }
}

