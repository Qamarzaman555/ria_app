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
  Get.put(ScanAndPersmissionController());
  Get.put(ConnectionController());
  Get.put(HomeController());
  Get.put(SettingController());
}
