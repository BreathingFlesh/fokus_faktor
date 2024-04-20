import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

import '../database.dart';

AppDatabase? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();

  // Datebank lösche
  // await database!.delete(database!.todoItems).go();

  await database!.into(database!.todoItems).insert(TodoItemsCompanion.insert(
        title: 'todo: finish drift setup',
        content: 'We can now write queries and define our own tables.',
        category: 'gürkenkuchen.',
      ));
  List<TodoItem> allItems = await database!.select(database!.todoItems).get();

  print('items in database: $allItems');

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
