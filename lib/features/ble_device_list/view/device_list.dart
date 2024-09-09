import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_background/app_background.dart';
import '../../../common/app_headers/app_header.dart';
import '../../../utils/app_sizes.dart';
import '../../scan/presentation/controller/ble_controller.dart';
import '../../../common/bluetooth_diabled/bluetooth_offscreen.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
    return Scaffold(
        body: AppBackground(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.defaultSpace),
                child: AppHeader(
                  header: Text("Available Devices",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              ),
              Obx(() {
                if (controller.bluetoothState.value !=
                    BluetoothAdapterState.on) {
                  return const BluetoothOffScreen(
                      status: 'Bluetooth is Turned Off');
                } else if (controller.bluetoothState.value ==
                    BluetoothAdapterState.turningOn) {
                  return const BluetoothOffScreen(
                      status: 'Bluetooth is Turning On!');
                } else if (controller.scanResults.isEmpty) {
                  return const Center(child: Text('No devices found'));
                } else {
                  return Flexible(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(AppSizes.defaultSpace),
                      itemCount: controller.filteredResults.length,
                      itemBuilder: (context, index) {
                        final device = controller.filteredResults[index].device;
                        return GestureDetector(
                          onTap: () {
                            controller.connectToDevice(device);
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.defaultSpace),
                              height: 50,
                              width: MediaQuery.sizeOf(context).width * 80,
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    device.platformName.isEmpty
                                        ? 'Unknown Device'
                                        : device.platformName,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .apply(
                                            color: Colors.white,
                                            fontSizeDelta: 2),
                                  ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSizes.spaceBtwItems),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => controller.bluetoothState.value != BluetoothAdapterState.on
              ? const SizedBox()
              : FloatingActionButton(
                  onPressed: () async {
                    await controller.scanForDevices();
                  },
                  child: const Icon(Icons.search),
                ),
        ));
  }
}
