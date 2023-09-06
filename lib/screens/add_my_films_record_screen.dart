import 'package:flutter/material.dart';

class AddMyFilmsRecordScreen extends StatefulWidget {
  const AddMyFilmsRecordScreen({Key? key}) : super(key: key);

  @override
  _AddMyFilmsRecordScreenState createState() => _AddMyFilmsRecordScreenState();
}

class _AddMyFilmsRecordScreenState extends State<AddMyFilmsRecordScreen> {
  final TextEditingController _filmBrandController = TextEditingController();
  final TextEditingController _filmNameController = TextEditingController();
  final TextEditingController _filmTypeController = TextEditingController();
  final TextEditingController _filmSizeController = TextEditingController();
  final TextEditingController _filmIsoController = TextEditingController();
  final TextEditingController _framesNumberController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Film'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Film Brand
              TextFormField(
                controller: _filmBrandController,
                decoration: InputDecoration(labelText: 'Film Brand'),
              ),
              SizedBox(height: 16),

              // Film Name
              TextFormField(
                controller: _filmNameController,
                decoration: InputDecoration(labelText: 'Film Name'),
              ),
              SizedBox(height: 16),

              // Film Type
              TextFormField(
                controller: _filmTypeController,
                decoration: InputDecoration(labelText: 'Film Type'),
              ),
              SizedBox(height: 16),

              // Film Size
              TextFormField(
                controller: _filmSizeController,
                decoration: InputDecoration(labelText: 'Film Size'),
              ),
              SizedBox(height: 16),

              // Film ISO
              TextFormField(
                controller: _filmIsoController,
                decoration: InputDecoration(labelText: 'Film ISO'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              // Frames Number
              TextFormField(
                controller: _framesNumberController,
                decoration: InputDecoration(labelText: 'Frames Number'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              // Expiration Date
              TextFormField(
                controller: _expirationDateController,
                decoration: InputDecoration(labelText: 'Expiration Date'),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 16),

              // Quantity
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
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
                  // Then, navigate back to the previous screen or perform any other actions
                },
                child: const Text('Save Film'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
