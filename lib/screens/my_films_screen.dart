import 'package:flutter/material.dart';

class FilmsScreen extends StatelessWidget {
  const FilmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Films'),
      ),
      body: const Center(
        child: Text('Films Screen Content'),
      ),
    );
  }
}
