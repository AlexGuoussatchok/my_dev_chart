import 'package:flutter/material.dart';

class LensesScreen extends StatelessWidget {
  const LensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lenses'),
      ),
      body: const Center(
        child: Text('Lenses Screen Content'),
      ),
    );
  }
}
