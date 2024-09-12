import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../scan/presentation/controller/ble_controller.dart';

class ScanDevicesButton extends StatelessWidget {
  const ScanDevicesButton({
    super.key,
    required this.controller,
  });

  final ScanAndPersmissionController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.bluetoothState.value != BluetoothAdapterState.on
          ? const SizedBox()
          : FloatingActionButton(
              backgroundColor: Colors.white60,
              onPressed: () async {
                /// Scans for devices and updates Device List View
                await controller.scanForDevices();
              },
              child: const Icon(Icons.search),
            ),
    );
  }
}
