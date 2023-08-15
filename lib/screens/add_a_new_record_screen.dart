import 'package:flutter/material.dart';

class AddNewRecordScreen extends StatelessWidget {
  const AddNewRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Record'),
      ),
      body: Center(
        child: Text('Add A New Record Screen Content'),
      ),
    );
  }
}