import 'package:flutter/material.dart';

class MyDevNotesScreen extends StatelessWidget {
  const MyDevNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Dev Notes'),
      ),
      body: Center(
        child: Text('My Dev Notes Screen Content'),
      ),
    );
  }
}
