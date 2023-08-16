import 'package:flutter/material.dart';
import 'package:my_dev_chart/lists/iso.dart';
import 'package:my_dev_chart/lists/film_types.dart';
import 'package:my_dev_chart/lists/cameras.dart';
import 'package:my_dev_chart/lists/lenses.dart';
import 'package:my_dev_chart/lists/developers.dart';
import 'package:my_dev_chart/lists/dilutions.dart';
import 'package:my_dev_chart/databases/database_helper.dart';

class TimeEditingController extends TextEditingController {
  @override
  set text(String newText) {
    value = value.copyWith(
      text: _formatTimeInput(newText),
      selection: TextSelection.fromPosition(
        TextPosition(offset: _formatTimeInput(newText).length),
      ),
    );
  }

  String _formatTimeInput(String input) {
    final sanitizedInput = input.replaceAll(RegExp(r'[^\d]'), '');

    if (sanitizedInput.length <= 2) {
      return '${sanitizedInput.padRight(2, ' ')} (min) :';
    } else if (sanitizedInput.length <= 4) {
      return '${sanitizedInput.substring(0, 2)} (min) : ${sanitizedInput.substring(2).padRight(2, ' ')} (sec)';
    } else {
      return '${sanitizedInput.substring(0, 2)} (min) : ${sanitizedInput.substring(2, 4)} (sec)';
    }
  }
}

class AddNewRecordScreen extends StatefulWidget {
  @override
  _AddNewRecordScreenState createState() => _AddNewRecordScreenState();
}

class _AddNewRecordScreenState extends State<AddNewRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  int? _filmNumber;
  String? _selectedIso;
  String? _filmType;
  String? _selectedCamera;
  String? _selectedLenses;
  String? _selectedDeveloper;
  String? _selectedDilution;
  String? _developingTime;
  double? _temperature;
  String? _comments;

  TextEditingController _filmNumberController = TextEditingController();
  int _lastUsedFilmNumber = 0;

  TimeEditingController _timeController = TimeEditingController();

  @override
  void initState() {
    super.initState();
    _filmNumberController.text = (_lastUsedFilmNumber + 1).toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _lastUsedFilmNumber = _filmNumber ?? _lastUsedFilmNumber;
      _filmNumberController.text = (_lastUsedFilmNumber + 1).toString();

      int year = _selectedDate?.year ?? DateTime.now().year;

      Map<String, dynamic> filmData = {
        'filmNumber': _filmNumberController.text,
        'selectedDate': _selectedDate,
        'selectedIso': _selectedIso,
        'filmType': _filmType,
        'selectedCamera': _selectedCamera,
        'selectedLenses': _selectedLenses,
        'selectedDeveloper': _selectedDeveloper,
        'selectedDilution': _selectedDilution,
        'developingTime': _developingTime,
        'temperature': _temperature,
        'comments': _comments,
      };

      await DatabaseHelper().insertFilm(filmData, year);

      // Refresh the UI or navigate to another screen as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add A New Record'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _filmNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Film Number'),
                onSaved: (value) => _filmNumber = int.tryParse(value ?? ''),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: _selectedDate != null
                        ? TextEditingController(text: _selectedDate!.toLocal().toString().split(' ')[0])
                        : null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedIso,
                items: isoValues.map((iso) {
                  return DropdownMenuItem<String>(
                    value: iso,
                    child: Text(iso),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIso = value;
                  });
                },
                decoration: InputDecoration(labelText: 'ISO'),
                onSaved: (value) => _selectedIso = value,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _filmType,
                items: filmTypeValues.map((filmType) {
                  return DropdownMenuItem<String>(
                    value: filmType,
                    child: Text(filmType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _filmType = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Film Type'),
                onSaved: (value) => _filmType = value,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCamera,
                items: camerasValues.map((camera) {
                  return DropdownMenuItem<String>(
                    value: camera,
                    child: Text(camera),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCamera = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Camera'),
                onSaved: (value) => _selectedCamera = value,
              ),
              DropdownButtonFormField<String>(
                value: _selectedLenses,
                items: lensesValues.map((lens) {
                  return DropdownMenuItem<String>(
                    value: lens,
                    child: Text(lens),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLenses = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Lenses'),
                onSaved: (value) => _selectedLenses = value,
              ),
              DropdownButtonFormField<String>(
                value: _selectedDeveloper,
                items: developersValues.map((developer) {
                  return DropdownMenuItem<String>(
                    value: developer,
                    child: Text(developer),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDeveloper = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Developer'),
                onSaved: (value) => _selectedDeveloper = value,
              ),
              DropdownButtonFormField<String>(
                value: _selectedDilution,
                items: dilutionsValues.map((dilution) {
                  return DropdownMenuItem<String>(
                    value: dilution,
                    child: Text(dilution),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDilution = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Dilution'),
                onSaved: (value) => _selectedDilution = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Developing Time (min : sec)'),
                onSaved: (value) => _developingTime = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Temperature (°C)'),
                onSaved: (value) => _temperature = double.tryParse(value ?? ''),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Comments'),
                onSaved: (value) => _comments = value,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
