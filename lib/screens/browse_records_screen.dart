import 'package:flutter/material.dart';

class BrowseRecordsScreen extends StatelessWidget {
  const BrowseRecordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Records'),
      ),
      body: Center(
        child: Text('Browse RecordsScreen Screen Content'),
      ),
    );
  }
}