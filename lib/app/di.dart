import 'package:get/get.dart';

import '../features/scan/presentation/controller/ble_controller.dart';

/// -- Dependancy Injection

// class GeneralBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(BluetoothController());
//   }
// }

di() {
  Get.put(BluetoothController());
}
