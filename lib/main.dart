import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions(); // Request storage permissions before running the app
  runApp(MyApp());
}

Future<void> _requestPermissions() async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    // Permission granted, you can access external storage.
  } else {
    // Permission denied, handle accordingly.
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Dev Chart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(key: Key('homeScreen')),
    );
  }
}
