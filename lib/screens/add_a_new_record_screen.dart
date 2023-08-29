import 'package:flutter/material.dart';
import 'package:my_dev_chart/lists/iso.dart';
import 'package:my_dev_chart/lists/film_types.dart';
import 'package:my_dev_chart/lists/cameras.dart';
import 'package:my_dev_chart/lists/lenses.dart';
import 'package:my_dev_chart/lists/developers.dart';
import 'package:my_dev_chart/lists/dilutions.dart';
import 'package:my_dev_chart/databases/database_helper.dart';
import 'package:my_dev_chart/lists/films_list.dart';

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
    final sanitizedInput = input.replaceAll(RegExp(r'\D'), '');

    if (sanitizedInput.length <= 2) {
      return '${sanitizedInput.padRight(2, ' ')} (min) :';
    } else if (sanitizedInput.length <= 4) {
      return '${sanitizedInput.substring(0, 2)} (min) : ${sanitizedInput
          .substring(2).padRight(2, ' ')} (sec)';
    } else {
      return '${sanitizedInput.substring(0, 2)} (min) : ${sanitizedInput
          .substring(2, 4)} (sec)';
    }
  }
}

class AddNewRecordScreen extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const AddNewRecordScreen({required this.dbHelper, Key? key}) : super(key: key);

  @override
  _AddNewRecordScreenState createState() => _AddNewRecordScreenState();
}

class _AddNewRecordScreenState extends State<AddNewRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _filmNumberController = TextEditingController();
  int _lastUsedFilmNumber = 0;
  DateTime? _selectedDate;
  String? _selectedFilm;
  String? _selectedIso;
  String? _filmType;
  String? _selectedCamera;
  String? _selectedLenses;
  String? _selectedDeveloper;
  String? _selectedDilution;
  String? _developingTime;
  double? _temperature;
  String? _comments;

  TimeEditingController _timeController = TimeEditingController();

  bool _areRequiredFieldsFilled = false;

  @override
  void initState() {
    super.initState();
    fetchAndSetFilmNumber();
    _filmType = 'type 135';
  }

  Future<void> fetchAndSetFilmNumber() async {
    final highestFilmNumber = await widget.dbHelper.getHighestFilmNumber();
    setState(() {
      _lastUsedFilmNumber = highestFilmNumber;
      _filmNumberController.text = _lastUsedFilmNumber.toString();
    });
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

  Future<void> insertFilm() async {
    // Create filmData using user input or other data
    Map<String, dynamic> filmData = {
      // ... initialize filmData with user input
    };

    // Call the insertFilmWithContext method with filmData
    await widget.dbHelper.insertFilmWithContext(context, filmData);
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Increment film number
      _lastUsedFilmNumber++;
      _filmNumberController.text = _lastUsedFilmNumber.toString();

      Map<String, dynamic> filmData = {
        'filmNumber': _filmNumberController.text,
        'date': _selectedDate?.toIso8601String(),
        'film': _selectedFilm,
        'selectedIso': _selectedIso,
        'filmType': _filmType,
        'camera': _selectedCamera,
        'lenses': _selectedLenses,
        'developer': _selectedDeveloper,
        'dilution': _selectedDilution,
        'developingTime': _developingTime,
        'temperature': _temperature,
        'comments': _comments,
      };

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add A New Record'),
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            _areRequiredFieldsFilled = _formKey.currentState!.validate();
          });
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _filmNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Film Number'),
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Film Number';
                  }
                  return null;
                },
                onSaved: (value) => _selectedFilm = value,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: _selectedDate != null
                        ? TextEditingController(
                        text:
                        _selectedDate!.toLocal().toString().split(' ')[0])
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
              DropdownButtonFormField<String>(
                value: _selectedFilm,
                items: filmsList.map((film) {
                  return DropdownMenuItem<String>(
                    value: film,
                    child: Text(film),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFilm = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Film'),
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Film';
                  }
                  return null;
                },
                onSaved: (value) => _selectedFilm = value,
              ),
              DropdownButtonFormField<String>(
                value: _selectedIso,
                items: isoValues.map((iso) {
                  return DropdownMenuItem<String>(
                    value: iso,
                    child: Text(iso),
                  );
                }).toList(),
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Film ISO';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _selectedIso = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'ISO'),
                onSaved: (value) => _selectedIso = value!, // Assign to _selectedIso
              ),

              DropdownButtonFormField<String>(
                value: _filmType,
                items: filmTypeValues.map((filmType) {
                  return DropdownMenuItem<String>(
                    value: filmType,
                    child: Text(filmType),
                  );
                }).toList(),
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose the Film type';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _filmType = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Film Type'),
                onSaved: (value) => _filmType = value!, // Assign to _filmType
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
                decoration: const InputDecoration(labelText: 'Camera'),
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
                decoration: const InputDecoration(labelText: 'Lenses'),
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
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose the developer used';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _selectedDeveloper = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Developer'),
                onSaved: (value) => _selectedDeveloper = value!, // Assign to _selectedDeveloper
              ),

              DropdownButtonFormField<String>(
                value: _selectedDilution,
                items: dilutionsValues.map((dilution) {
                  return DropdownMenuItem<String>(
                    value: dilution,
                    child: Text(dilution),
                  );
                }).toList(),
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose the dilution';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _selectedDilution = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Dilution'),
                onSaved: (value) => _selectedDilution = value!, // Assign to _selectedDilution
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Developing Time (min : sec)'),
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the developing time';
                  }
                  return null;
                },
                onSaved: (value) => _developingTime = value!, // Assign to _developingTime
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Temperature (°C)'),
                // Validator for required field
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the temperature';
                  }
                  return null;
                },
                onSaved: (value) => _temperature = double.parse(value!), // Assign to _temperature
              ),

              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Comments'),
                onSaved: (value) => _comments = value,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _areRequiredFieldsFilled ? _saveForm : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  _areRequiredFieldsFilled ? Colors.blue : Colors.grey,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
