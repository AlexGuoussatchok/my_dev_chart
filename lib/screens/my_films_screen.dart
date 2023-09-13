import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/my_inventory_database_helper.dart';
import 'package:my_dev_chart/screens/add_my_films_record_screen.dart';
import 'package:my_dev_chart/extra_classes/my_films.dart';

class FilmsScreen extends StatelessWidget {
  final InventoryDatabaseHelper databaseHelper = InventoryDatabaseHelper();

  FilmsScreen({Key? key}) : super(key: key) {
    databaseHelper.initialize(); // Initialize the database when the screen is opened
  }


  // Close the database when the screen is disposed
  Future<void> closeDatabase() async {
    await databaseHelper.close();
  }

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
                    builder: (context) => const AddMyFilmsRecordScreen(),
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
      body: FutureBuilder<List<MyFilms>>(
        future: InventoryDatabaseHelper.getAllFilms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator if data is being fetched
            print('Fetching data from the database...');
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error
            print('Error fetching data: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Display a message when there are no records
            print('No records found in the database.');
            return const Center(
              child: Text('There are no records in the db'),
            );
          } else {
            // Display the list of films
            List<MyFilms> films = snapshot.data!;
            if (films.isEmpty) {
              // No films found
              print('No films found in the database.');
              return const Center(
                child: Text('No films found in the database'),
              );
            }
            // Print films to debug
            films.forEach((film) {
              print('Film: ${film.film}');
            });

            return ListView.builder(
              itemCount: films.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(films[index].film),
                  // Display other film details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
