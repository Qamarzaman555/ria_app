import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ria_app/features/connected_device/controller/connection_controller.dart';

import '../../../common/bluetooth_diabled/bluetooth_offscreen.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../scan/presentation/controller/scan_controller.dart';
import 'device_list_tile.dart';

class DevicesList extends StatelessWidget {
  const DevicesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ScanAndPersmissionController bleController =
        Get.find<ScanAndPersmissionController>();
    final ConnectionController connectionController =
        Get.find<ConnectionController>();
    return Obx(() {
      if (bleController.bluetoothState.value != BluetoothAdapterState.on) {
        return const BluetoothOffScreen(status: 'Bluetooth is Turned Off');
      } else if (bleController.bluetoothState.value ==
          BluetoothAdapterState.turningOn) {
        return const BluetoothOffScreen(status: 'Bluetooth is Turning On!');
      } else if (bleController.filteredResults.isEmpty) {
        return Center(
            child: Text('No devices found', style: AppStyles.headlineMedium));
      } else {
        /// ListView
        return Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            itemCount: bleController.filteredResults.length,
            itemBuilder: (context, index) {
              final device = bleController.filteredResults[index].device;

              /// Device
              return GestureDetector(
                onTap: () {
                  connectionController.connectToDevice(device);
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
