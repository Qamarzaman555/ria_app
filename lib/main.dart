import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  /// -- Dependancy Injection
  await di();

  /// -- Load all the Material Design / Themes
  runApp(const MyApp());
}
