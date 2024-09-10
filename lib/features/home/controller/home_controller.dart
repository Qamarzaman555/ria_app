import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  RxInt currentReading = 0.obs;
  RxString airQualityLabel = 'Good'.obs;
  Rx<Color> airQualityColor = Colors.green.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize by generating the first random reading
    updateCurrentReading();
  }

  // Function to generate random readings between 0 and 3000
  void updateCurrentReading() {
    currentReading.value =
        Random().nextInt(3001); // Generate random value from 0 to 3000
    updateAirQuality(
        currentReading.value); // Update the air quality based on reading
  }

  // Function to determine air quality and corresponding color
  void updateAirQuality(int reading) {
    if (reading < 800) {
      airQualityLabel.value = 'Good';
      airQualityColor.value = Colors.green;
    } else if (reading >= 800 && reading < 1200) {
      airQualityLabel.value = 'Reasonable';
      airQualityColor.value = Colors.lightBlue;
    } else if (reading >= 1200 && reading < 2000) {
      airQualityLabel.value = 'Poor';
      airQualityColor.value = Colors.yellow;
    } else if (reading >= 2000 && reading < 3000) {
      airQualityLabel.value = 'Bad';
      airQualityColor.value = Colors.orange;
    } else {
      airQualityLabel.value = 'Very Bad';
      airQualityColor.value = Colors.red;
    }
  }
}
