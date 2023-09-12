import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/my_inventory_database_helper.dart';
import 'package:my_dev_chart/extra_classes/my_films.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_dev_chart/lists/film_sizes_list.dart';


class AddMyFilmsRecordScreen extends StatefulWidget {
  const AddMyFilmsRecordScreen({Key? key}) : super(key: key);

  @override
  _AddMyFilmsRecordScreenState createState() => _AddMyFilmsRecordScreenState();
}

class _AddMyFilmsRecordScreenState extends State<AddMyFilmsRecordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Database _userFilmsRecordsDatabase; // For user film records
  late Database _readOnlyFilmsCatalogueDatabase; // For read-only film brands;

  String _selectedBrand = ''; // Initialize with an empty string
  String _selectedFilmName = ''; // Initialize with an empty string
  String _selectedFilmType = ''; // Initialize with an empty string
  String _selectedFilmSize = '';
  String _selectedFilmISO = '';
  String _selectedExpirationDate = 'Undefined'; // Default value

  // Variable to store the selected date from the date picker
  DateTime? _selectedDate;

  List<String> _brandList = []; // Initialize as an empty list
  List<String> _filmNames = []; // Initialize as an empty list

  final TextEditingController _filmBrandController = TextEditingController();
  final TextEditingController _filmNameController = TextEditingController();
  final TextEditingController _filmTypeController = TextEditingController();
  final TextEditingController _filmSizeController = TextEditingController();
  final TextEditingController _filmIsoController = TextEditingController();
  final TextEditingController _framesNumberController = TextEditingController(text: '36');
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
    _selectedFilmSize = filmSizeValues.isNotEmpty ? filmSizeValues[0] : '';
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

  Future<List<String>> fetchFilmNames(String selectedBrand) async {
    final tableName = '$selectedBrand' + '_films_catalogue';
    final queryResult = await _readOnlyFilmsCatalogueDatabase.query(
      tableName,
      columns: ['film_name'],
    );

    final filmNames = queryResult
        .map((row) => row['film_name'].toString())
        .toList();

    return filmNames;
  }

  Future<String> fetchFilmType(String selectedBrand, String selectedFilmName) async {
    final tableName = '$selectedBrand' + '_films_catalogue';
    final queryResult = await _readOnlyFilmsCatalogueDatabase.query(
      tableName,
      columns: ['film_type'],
      where: 'film_name = ?',
      whereArgs: [selectedFilmName],
    );

    if (queryResult.isNotEmpty) {
      final filmType = queryResult.first['film_type'] as String;
      print('Fetched film type: $filmType'); // Add this print statement
      return filmType;
    } else {
      print('Film type not found.'); // Add this print statement
      return ''; // Return an empty string or handle the case when film type is not found
    }
  }

  Future<String> fetchFilmISO(String selectedBrand, String selectedFilmName) async {
    final tableName = '$selectedBrand' + '_films_catalogue';
    final queryResult = await _readOnlyFilmsCatalogueDatabase.query(
      tableName,
      columns: ['film_speed'],
      where: 'film_name = ?',
      whereArgs: [selectedFilmName],
    );

    if (queryResult.isNotEmpty) {
      final filmISO = queryResult.first['film_speed'].toString();
      return filmISO;
    } else {
      return '';
    }
  }

  // Function to open the date picker
  Future<void> _pickExpirationDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null && picked != _selectedDate) {
      setState(() {
        // Format the picked date as yyyy-mm and store it
        _selectedExpirationDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}";
        _selectedDate = picked;
      });
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
                      _selectedBrand = newValue!;
                      // Fetch film names based on the selected brand
                      fetchFilmNames(_selectedBrand).then((filmNames) {
                        setState(() {
                          _filmNames = filmNames;
                          // If available, set the first film name as the initial selection
                          _selectedFilmName = _filmNames.isNotEmpty ? _filmNames[0] : '';
                        });
                      });
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

                // Film Name Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedFilmName,
                  decoration: const InputDecoration(labelText: 'Film Name'),
                  items: _filmNames.map((String filmName) {
                    return DropdownMenuItem<String>(
                      value: filmName,
                      child: Text(filmName),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilmName = newValue!;
                      // Fetch the film type from the database based on the selected brand and film name
                      fetchFilmType(_selectedBrand, _selectedFilmName).then((filmType) {
                        print('Fetched film type: $filmType'); // Add this print statement
                        setState(() {
                          _selectedFilmType = filmType; // Update _selectedFilmType
                          _filmTypeController.text = filmType; // Update the text in the controller
                        });
                        print('Updated film type in controller: ${_filmTypeController.text}');
                      });
                      // Fetch the film ISO from the database based on the selected brand and film name
                      fetchFilmISO(_selectedBrand, _selectedFilmName).then((filmISO) {
                        setState(() {
                          _filmIsoController.text = filmISO;
                        });
                      });
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Film Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Film Type
                TextFormField(
                  controller: _filmTypeController, // Use the TextEditingController
                  decoration: const InputDecoration(labelText: 'Film Type'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Film Type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),


                // Film Size Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedFilmSize,
                  decoration: const InputDecoration(labelText: 'Film Size'),
                  items: filmSizeValues.map((String size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilmSize = newValue ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Film Size';
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
                ListTile(
                  title: Text('Expiration Date'),
                  subtitle: Text(
                    _selectedExpirationDate == 'Undefined'
                        ? 'If date not set, the expiration date is undefined'
                        : 'Expiration Date: $_selectedExpirationDate',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _pickExpirationDate(context),
                    child: Text('Set Date'),
                  ),
                ),

                const SizedBox(height: 16),

                // Quantity
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(labelText: 'Quantity'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Frames Quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        int currentValue = int.tryParse(_quantityController.text) ?? 1;
                        setState(() {
                          currentValue++;
                          _quantityController.text = currentValue.toString();
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {
                        int currentValue = int.tryParse(_quantityController.text) ?? 1;
                        if (currentValue > 1) {
                          setState(() {
                            currentValue--;
                            _quantityController.text = currentValue.toString();
                          });
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _isFormValid
                      ? () async {
                    final filmBrand = _filmBrandController.text;
                    final filmName = _filmNameController.text;
                    final filmType = _filmTypeController.text;
                    final filmSize = _filmSizeController.text;
                    final filmIso = int.tryParse(_filmIsoController.text) ?? 0;
                    final framesNumber = int.tryParse(_framesNumberController.text) ?? 0;
                    final expirationDate =
                    _selectedExpirationDate == 'Undefined' ? 'Undefined' : _selectedExpirationDate;
                    final quantity = int.tryParse(_quantityController.text) ?? 0;

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
