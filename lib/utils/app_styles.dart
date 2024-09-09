import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  AppStyles._internal();
  static TextStyle headlineStyle = Theme.of(Get.context!)
      .textTheme
      .headlineMedium!
      .copyWith(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle bodyMedium = GoogleFonts.lato(
      fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white);

  static TextStyle buttonText = GoogleFonts.ubuntu(
      fontSize: 24, fontWeight: FontWeight.w400, color: Colors.blue);

  static TextStyle headlineMedium = GoogleFonts.ubuntu(
      fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle labelLarge = Theme.of(Get.context!)
      .textTheme
      .labelLarge!
      .apply(color: Colors.white, fontSizeDelta: 2);

  static TextStyle bodyLarge = Theme.of(Get.context!)
      .textTheme
      .bodyLarge!
      .apply(color: Colors.white, fontWeightDelta: 2);

  static TextStyle ubuntuHeadlineMedium = GoogleFonts.ubuntu(
      fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle ubuntuHeadlineSmall = GoogleFonts.ubuntu(
      fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle ubuntuHeadlineLarge = GoogleFonts.ubuntu(
      fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white);
}
