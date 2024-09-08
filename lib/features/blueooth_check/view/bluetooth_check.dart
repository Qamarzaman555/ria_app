import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../scan/presentation/controller/ble_controller.dart';
import '../../scan/presentation/view/scan.dart';
import '../../../common/bluetooth_diabled/bluetooth_offscreen.dart';

class BluetoothCheckScreen extends StatelessWidget {
  const BluetoothCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
    return Obx(() {
      if (controller.bluetoothState.value == BluetoothAdapterState.unknown) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (controller.bluetoothState.value == BluetoothAdapterState.on) {
        return const Scan();
      } else if (controller.bluetoothState.value ==
          BluetoothAdapterState.turningOn) {
        return const BluetoothOffScreen(status: 'Bluetooth is Turning On!');
      } else {
        return const BluetoothOffScreen(status: 'Bluetooth is Turned Off');
      }
    });
  }
}
