import 'package:flutter/material.dart';

import 'outlined_btn_theme.dart';

class AppTheme {
  AppTheme._();

  // Customizable light Theme

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 177, 179, 180),
    outlinedButtonTheme: AppOutlinedBtnTheme.lightOutlineButtonTheme,
  );

  // Customizable light Theme

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
  );
}
