import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class Permissions {
  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();

      bool allGranted =
          statuses.values.every((status) => status == PermissionStatus.granted);
      return allGranted;
    } else {
      // For iOS, you might want to handle this differently or check other permissions
      return true;
    }
  }

  static Future<bool> enableLocationService() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      await Geolocator.openLocationSettings();
      isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    }

    return isLocationEnabled;
  }
}
