import 'package:get/get.dart';

import '../features/connected_device/controller/connection_controller.dart';
import '../features/home/controller/home_controller.dart';
import '../features/scan/presentation/controller/ble_controller.dart';
import '../features/settings/controller/setting_controller.dart';

/// -- Dependancy Injection

// class GeneralBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(BluetoothController());
//   }
// }

di() {
  /// For Permission & Scanning
  Get.put(ScanAndPersmissionController());

  /// Connects to BLE Devices
  Get.put(ConnectionController());

  /// Reads & Notifies BLE Device data & Charts Data
  Get.put(HomeController());

  /// Read & Write Threshold
  Get.put(SettingController());
}
