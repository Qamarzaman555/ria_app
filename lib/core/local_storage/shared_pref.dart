import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  RxString deviceName = ''.obs;
  // Save device name with the MAC address as key
  Future<void> saveDeviceName(String macAddress, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(macAddress, name);
  }

  // Retrieve the device name by MAC address
  Future<String> getDeviceName(String macAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    deviceName.value = prefs.getString(macAddress) ?? '';
    return deviceName.value;
  }
}
