import 'package:get/get.dart';

class SettingController extends GetxController {
  // Observable value for slider
  var sliderValue = 1800.0.obs;

  // Method to update the slider value
  void updateSliderValue(double value) {
    sliderValue.value = value;
  }
}
