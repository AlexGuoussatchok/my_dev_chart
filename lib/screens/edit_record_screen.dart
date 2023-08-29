import 'package:flutter/material.dart';
import 'package:my_dev_chart/extra_classes/record_class.dart';
import 'package:my_dev_chart/databases/database_helper.dart';

class EditRecordScreen extends StatefulWidget {
  final RecordClass record;

  EditRecordScreen(this.record);

  @override
  _EditRecordScreenState createState() => _EditRecordScreenState();
}

class _EditRecordScreenState extends State<EditRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _filmNumberController = TextEditingController();
  TextEditingController _filmController = TextEditingController();
  TextEditingController _isoController = TextEditingController();
  TextEditingController _filmTypeController = TextEditingController();
  TextEditingController _cameraController = TextEditingController();
  TextEditingController _lensesController = TextEditingController();
  TextEditingController _developerController = TextEditingController();
  TextEditingController _dilutionController = TextEditingController();
  TextEditingController _developingTimeController = TextEditingController();
  TextEditingController _temperatureController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _filmNumberController.text = widget.record.filmNumber;
    _filmController.text = widget.record.film;
    _isoController.text = widget.record.selectedIso;
    _filmTypeController.text = widget.record.filmType;
    _cameraController.text = widget.record.camera ?? '';
    _lensesController.text = widget.record.lenses ?? '';
    _developerController.text = widget.record.developer;
    _dilutionController.text = widget.record.dilution;
    _developingTimeController.text = widget.record.developingTime ?? '';
    _temperatureController.text = widget.record.temperature.toString();
    _commentsController.text = widget.record.comments ?? '';
    _selectedDate = widget.record.date;
  }

  Future<void> _updateRecord() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> updatedData = {
        'filmNumber': _filmNumberController.text,
        'date': _selectedDate?.toIso8601String(),
        'film': _filmController.text,
        'selectedIso': _isoController.text,
        'filmType': _filmTypeController.text,
        'camera': _cameraController.text,
        'lenses': _lensesController.text,
        'developer': _developerController.text,
        'dilution': _dilutionController.text,
        'developingTime': _developingTimeController.text,
        'temperature': double.parse(_temperatureController.text),
        'comments': _commentsController.text,
      };

      await DatabaseHelper().updateRecord(updatedData);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Record'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _filmNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Film Number'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _filmController,
                decoration: const InputDecoration(labelText: 'Film'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _isoController,
                decoration: const InputDecoration(labelText: 'ISO'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _filmTypeController,
                decoration: const InputDecoration(labelText: 'Film Type'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _cameraController,
                decoration: const InputDecoration(labelText: 'Camera'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _lensesController,
                decoration: const InputDecoration(labelText: 'Lenses'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _developerController,
                decoration: const InputDecoration(labelText: 'Developer'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _dilutionController,
                decoration: const InputDecoration(labelText: 'Dilution'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _developingTimeController,
                decoration: const InputDecoration(labelText: 'Developing Time'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _temperatureController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Temperature'),
                // Add validation and saving logic
              ),
              TextFormField(
                controller: _commentsController,
                decoration: const InputDecoration(labelText: 'Comments'),
                // Add validation and saving logic
              ),
              ElevatedButton(
                onPressed: _updateRecord,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
