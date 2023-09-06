import 'package:flutter/material.dart';
import 'package:my_dev_chart/screens/add_my_films_record_screen.dart';

class FilmsScreen extends StatelessWidget {
  const FilmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Films'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'addFilm') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMyFilmsRecordScreen(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'addFilm',
                  child: Text('Add a film'),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('My Films Screen Content'),
      ),
    );
  }
}
