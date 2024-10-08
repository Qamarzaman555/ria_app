import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_background/app_background.dart';
import '../../../common/app_headers/app_header.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../scan/presentation/controller/scan_controller.dart';
import '../widgets/devices_list.dart';
import '../widgets/scan_devices_button.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanAndPersmissionController controller = Get.find();
    return Scaffold(

        /// -- Linear Gradient Background
        body: AppBackground(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.defaultSpace),

                  /// Header
                  child: AppHeader(
                    header: Text("Available Devices",
                        textAlign: TextAlign.center,
                        style: AppStyles.headlineMedium),
                  ),
                ),

                /// Device List View
                const DevicesList(),
              ],
            ),
          ),
        ),

        /// Scan for devices button
        floatingActionButton: ScanDevicesButton(controller: controller));
  }
}
