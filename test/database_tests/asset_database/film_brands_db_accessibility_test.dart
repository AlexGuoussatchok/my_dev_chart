import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_dev_chart/databases/film_brands_database_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized for asset loading.

  setUp(() async {
    // Mock asset loading for film_brands database.
    final channel = MethodChannel('plugins.flutter.io/assets');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'loadString' &&
          methodCall.arguments == 'assets/film_brands.db') {
        // Provide an empty string for asset loading.
        return '';
      }
      return null;
    });

    // Initialize the film brands database.
    final filmBrandsHelper = FilmBrandsDatabaseHelper.instance;
    await filmBrandsHelper.database;
  });

  tearDown(() {
    // Restore the original asset loading behavior.
    final channel = MethodChannel('plugins.flutter.io/assets');
    channel.setMockMethodCallHandler(null);
  });

  test('Film Brands Database Accessibility Test', () async {
    final filmBrandsHelper = FilmBrandsDatabaseHelper.instance;

    // Initialize the database.
    final db = await filmBrandsHelper.database;

    // Perform a simple query to check if the database is accessible.
    final result = await db.query('film_brands');

    // Assert that the result is not null, indicating successful access to the database.
    expect(result, isNotNull);

    // Clean up: close the database.
    await db.close();
  });
}
