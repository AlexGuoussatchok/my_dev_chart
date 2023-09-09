import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/my_inventory_database_helper.dart';
import 'package:my_dev_chart/extra_classes/my_films.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class AddMyFilmsRecordScreen extends StatefulWidget {
  const AddMyFilmsRecordScreen({Key? key}) : super(key: key);

  @override
  _AddMyFilmsRecordScreenState createState() => _AddMyFilmsRecordScreenState();
}

class _AddMyFilmsRecordScreenState extends State<AddMyFilmsRecordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Database _userFilmsRecordsDatabase; // For user film records
  late Database _readOnlyFilmsCatalogueDatabase; // For read-only film brands;

  String _selectedBrand = 'Ilford'; // Initialize with a default value

  List<String> _brandList = [];
  final TextEditingController _filmBrandController = TextEditingController();
  final TextEditingController _filmNameController = TextEditingController();
  final TextEditingController _filmTypeController = TextEditingController();
  final TextEditingController _filmSizeController = TextEditingController();
  final TextEditingController _filmIsoController = TextEditingController();
  final TextEditingController _framesNumberController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Initialize the user film records database
    _initUserFilmsRecordsDatabase();
    // Initialize the read-only database for film brands
    _initReadOnlyFilmsCatalogueDatabase();
  }

  Future<void> _initReadOnlyFilmsCatalogueDatabase() async {
    // Open the read-only database for film brands directly from assets
    try {
      print('Opening read-only films catalogue database...');
      _readOnlyFilmsCatalogueDatabase = await openDatabase('assets/films_catalogue.db');
      print('Read-only films catalogue database opened successfully.');
      await _loadBrandNames(); // Wait for brand names to be loaded
      _selectedBrand = _brandList.isNotEmpty ? _brandList[0] : ''; // Set the selected brand if available
    } catch (e) {
      // Handle the error
      print('Error initializing read-only films catalogue database: $e');
    }
  }

  Future<void> _initUserFilmsRecordsDatabase() async {
    final dbPath = await getDatabasesPath();
    final userDbPath = join(dbPath, 'films_catalogue.db');

    // Open the user database for film records
    try {
      print('Opening user films records database...');
      _userFilmsRecordsDatabase = await openDatabase(userDbPath);
      print('User films records database opened successfully.');
    } catch (e) {
      // Handle the error
      print('Error initializing user films records database: $e');
    }
  }

  // Function to load brand names from the database
  Future<void> _loadBrandNames() async {
    try {
      const tableName = 'film_brands'; // Specify the table name here
      final dbPath = _readOnlyFilmsCatalogueDatabase.path; // Get the database path
      print('Loading brand names from table $tableName in database at path $dbPath...');
      print('Loading brand names...');
      final brands = await _readOnlyFilmsCatalogueDatabase.query('film_brands', columns: ['brand']);
      print('Query executed successfully.');
      print('Resulting brands: $brands'); // Print the query result

      // Extract brand names and sort them alphabetically
      final uniqueBrands = brands.map((brandMap) => brandMap['brand'].toString()).toSet().toList();
      uniqueBrands.sort();

      setState(() {
        print('Brand names loaded successfully.');
        _brandList = uniqueBrands;
        _selectedBrand = _brandList.isNotEmpty ? _brandList[0] : '';
      });
    } catch (e) {
      // Handle any errors that occur during the database query
      print('Error loading brand names: $e');
    }
  }


  @override
  void dispose() {
    // Close both databases when the screen is disposed
    _userFilmsRecordsDatabase.close();
    _readOnlyFilmsCatalogueDatabase.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_selectedBrand: $_selectedBrand');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Film'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled, // Disable auto-validation
            onChanged: () {
              // When the form changes, check if it's valid
              setState(() {
                _isFormValid = _formKey.currentState?.validate() ?? false;
              });
            },

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Film Brand

                DropdownButtonFormField<String>(
                  value: _selectedBrand, // Set the selected brand value
                  decoration: const InputDecoration(labelText: 'Film Brand'),
                  items: _brandList.map((String brand) {
                    return DropdownMenuItem<String>(
                      value: brand,
                      child: Text(brand),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBrand = newValue!; // Update the selected brand when the user makes a selection
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Film Brand'; // Add validation for selecting a brand
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Film Name
                TextFormField(
                  controller: _filmNameController,
                  decoration: const InputDecoration(labelText: 'Film Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Film Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Film Type
                TextFormField(
                  controller: _filmTypeController,
                  decoration: const InputDecoration(labelText: 'Film Type'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Film Type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Film Size
                TextFormField(
                  controller: _filmSizeController,
                  decoration: const InputDecoration(labelText: 'Film Size'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Film Size';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Film ISO
                TextFormField(
                  controller: _filmIsoController,
                  decoration: const InputDecoration(labelText: 'Film ISO'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Film ISO';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Frames Number
                TextFormField(
                  controller: _framesNumberController,
                  decoration: const InputDecoration(labelText: 'Frames Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Frames number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Expiration Date
                TextFormField(
                  controller: _expirationDateController,
                  decoration: const InputDecoration(labelText: 'Expiration Date'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Film Expiration Date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Quantity
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Frames Quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _isFormValid
                      ? () async {
                    // Implement the logic to save the film record
                    // You can access the form fields' values from the controllers
                    final filmBrand = _filmBrandController.text;
                    final filmName = _filmNameController.text;
                    final filmType = _filmTypeController.text;
                    final filmSize = _filmSizeController.text;
                    final filmIso = int.tryParse(_filmIsoController.text) ?? 0;
                    final framesNumber = int.tryParse(_framesNumberController.text) ?? 0;
                    final expirationDate = _expirationDateController.text;
                    final quantity = int.tryParse(_quantityController.text) ?? 0;

                    // Now, you have the values, perform validation if needed, and save the record
                    // Create a MyFilms object with the values
                    final film = MyFilms(
                      brand: filmBrand,
                      film: filmName,
                      filmType: filmType,
                      filmSize: filmSize,
                      filmIso: filmIso,
                      framesNumber: framesNumber,
                      expirationDate: expirationDate,
                      quantity: quantity.toString(),
                    );

                    // Save the film record to the database
                    await InventoryDatabaseHelper().insertFilm(film);

                    // Navigate back to the previous screen or perform any other actions
                  }
                      : null, // Disable button if form is invalid
                  child: const Text('Save Film'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
