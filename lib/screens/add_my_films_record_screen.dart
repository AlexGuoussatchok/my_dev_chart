import 'package:flutter/material.dart';
import 'package:my_dev_chart/databases/my_inventory_database_helper.dart';
import 'package:my_dev_chart/extra_classes/my_films.dart';


class AddMyFilmsRecordScreen extends StatefulWidget {
  const AddMyFilmsRecordScreen({Key? key}) : super(key: key);

  @override
  _AddMyFilmsRecordScreenState createState() => _AddMyFilmsRecordScreenState();
}

class _AddMyFilmsRecordScreenState extends State<AddMyFilmsRecordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
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
                TextFormField(
                  controller: _filmBrandController,
                  decoration: const InputDecoration(labelText: 'Film Brand'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Film Brand';
                    }
                    return null; // Return null for no validation error
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

                //Film Size
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

                // ... (Repeat for other input fields)

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

                  // Now, you have the values, perform validation if needed, and save the record
                  // Then, navigate back to the previous screen or perform any other actions
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
