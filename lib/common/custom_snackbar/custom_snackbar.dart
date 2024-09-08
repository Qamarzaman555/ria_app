//Show_toast.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showToast(String message) {
  return Get.snackbar('', message,
      duration: const Duration(seconds: 5),
      titleText: const SizedBox(),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      colorText: const Color(0xffffffff),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      isDismissible: true);
}
