import 'dart:io';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothManager {
  static bool isBluetoothOn = false;

  static void initBluetoothState() {
    FlutterBluePlus.adapterState.listen((state) {
      isBluetoothOn = (state == BluetoothAdapterState.on);
    });
  }

  static Future<bool> enableBluetooth() async {
    if (Platform.isAndroid && !isBluetoothOn) {
      try {
        await FlutterBluePlus.turnOn();
        return isBluetoothOn;
      } catch (e) {
        // Handle the error, possibly notify the user
        return false;
      }
    }

    return isBluetoothOn;
  }
}
