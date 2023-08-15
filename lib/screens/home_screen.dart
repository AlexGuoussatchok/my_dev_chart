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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Handle the 'Dev Chart' button press
                    },
                    child: Text(
                      'Dev Chart',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Handle the 'My Dev Chart' button press
                    },
                    child: Text(
                      'My Dev Chart',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      // Handle the 'My Dev Notes' button press
                    },
                    child: Text(
                      'My Dev Notes',
                      style: TextStyle(fontSize: 20 * 1.7), // Increase font size by 70%
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
