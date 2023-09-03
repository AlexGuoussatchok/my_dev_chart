import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/film_brands_database_helper.dart';

class AddMyFilmsRecordScreen extends StatefulWidget {
  const AddMyFilmsRecordScreen({Key? key}) : super(key: key);

  @override
  _AddMyFilmsRecordScreenState createState() => _AddMyFilmsRecordScreenState();
}

class _AddMyFilmsRecordScreenState extends State<AddMyFilmsRecordScreen> {
  List<String> availableFilmBrands = []; // Initialize an empty list
  String? selectedFilmBrand; // Initialize with null or a default value if needed

  @override
  void initState() {
    super.initState();
    loadFilmBrands();
  }

  Future<void> loadFilmBrands() async {
    final filmBrandsHelper = FilmBrandsDatabaseHelper.instance;
    final filmBrands = await filmBrandsHelper.getFilmBrands();

    final sortedFilmBrands = [...filmBrands]; // Create a copy of the original list
    sortedFilmBrands.sort(); // Sort the copy alphabetically

    setState(() {
      availableFilmBrands = sortedFilmBrands;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Film Brand:', // Update the label to "Film Brand"
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: selectedFilmBrand,
              onChanged: (newValue) {
                setState(() {
                  selectedFilmBrand = newValue;
                });
              },
              items: availableFilmBrands.map<DropdownMenuItem<String>>((String filmBrand) {
                return DropdownMenuItem<String>(
                  value: filmBrand,
                  child: Text(filmBrand),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedFilmBrand != null) {
                  final filmBrand = selectedFilmBrand;
                  // Perform validation if needed
                  // Save the film brand to the database or perform any other actions
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Film'),
            ),
          ],
        ),
      ),
    );
  }
}
