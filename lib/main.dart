import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'common/app_models/data_recorded_model.dart';

void main() async {
  /// -- Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// -- Initialized Path Directory
  var directory = await getApplicationDocumentsDirectory();

  /// -- Initialized Hive Database
  Hive.init(directory.path);

  // Register adapters
  Hive.registerAdapter(RecordedDataAdapter());

  /// -- Dependancy Injection
  await di();

  /// -- Load all the Material Design / Themes
  runApp(const MyApp());
}
