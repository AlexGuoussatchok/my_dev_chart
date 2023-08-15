import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Dev Chart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle the 'Dev Chart' button press
              },
              child: Text('Dev Chart'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the 'My Dev Chart' button press
              },
              child: Text('My Dev Chart'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the 'My Dev Notes' button press
              },
              child: Text('My Dev Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
