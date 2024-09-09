import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../../common/bluetooth_diabled/bluetooth_offscreen.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../scan/presentation/controller/ble_controller.dart';
import 'device_list_tile.dart';

class DevicesList extends StatelessWidget {
  const DevicesList({
    super.key,
    required this.controller,
  });

  final BluetoothController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.bluetoothState.value != BluetoothAdapterState.on) {
        return const BluetoothOffScreen(status: 'Bluetooth is Turned Off');
      } else if (controller.bluetoothState.value ==
          BluetoothAdapterState.turningOn) {
        return const BluetoothOffScreen(status: 'Bluetooth is Turning On!');
      } else if (controller.filteredResults.isEmpty) {
        return Center(
            child: Text('No devices found', style: AppStyles.headlineMedium));
      } else {
        /// ListView
        return Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            itemCount: controller.filteredResults.length,
            itemBuilder: (context, index) {
              final device = controller.filteredResults[index].device;

              /// Device
              return GestureDetector(
                onTap: () {
                  controller.connectToDevice(device);
                },
                child: DeviceListTile(device: device),
              );
            },
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSizes.spaceBtwItems),
          ),
        );
      }
    });
  }
}
