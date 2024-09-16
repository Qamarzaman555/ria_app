import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ria_app/common/app_headers/app_header.dart';

import '../../../common/app_background/app_background.dart';
import '../../../core/local_storage/shared_pref.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../controller/setting_controller.dart';

class Setting extends StatelessWidget {
  const Setting({super.key, required this.connectedDevice});
  final BluetoothDevice connectedDevice;

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.find();
    final SharedPrefsService prefsService = SharedPrefsService();
    prefsService.getDeviceName(connectedDevice.remoteId.toString());
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      /// -- Linear Gradient Background
      body: AppBackground(
        colors: const [
          Color.fromRGBO(75, 61, 133, 1),
          Color.fromRGBO(8, 12, 28, 1),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                AppHeader(
                  header: Text('Settings',
                      textAlign: TextAlign.center,
                      style: AppStyles.headlineMedium),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Device Info
                Text("Set Device Name", style: AppStyles.ubuntuHeadlineSmall),

                /// Update Device Info Field
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Obx(
                    () => TextFormField(
                      // initialValue: connectedDevice.platformName,
                      controller: nameController
                        ..text = prefsService.deviceName.value.isNotEmpty
                            ? prefsService.deviceName.value
                            : connectedDevice.platformName,
                      style: AppStyles.bodyMedium,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSizes
                                .defaultSpace), // Similar padding as before
                        filled: true,
                        fillColor: Colors
                            .white24, // Background color similar to the Container
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide
                              .none, // Removes the border to match Container look
                        ),
                      ),
                    ),
                  ),
                ),

                /// Update Threshold Slider
                const SizedBox(height: AppSizes.spaceBtwSections * 2),
                Text('Set Alert Threshold',
                    style: AppStyles.ubuntuHeadlineSmall),
                Obx(() => Text(
                    '${controller.sliderValue.value.toStringAsFixed(0)}ppm',
                    style: AppStyles.ubuntuHeadlineLarge)),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  child: RotatedBox(
                    quarterTurns: 3, // Rotate by 90 degrees
                    child: Obx(() => Slider(
                          value: controller.sliderValue.value,
                          onChanged: (value) {
                            controller.updateSliderValue(value.toInt());
                          },
                          min: 500,
                          max: 3000,
                          activeColor: const Color.fromRGBO(196, 196, 196, 1),
                          inactiveColor: const Color.fromRGBO(133, 133, 133, 1),
                        )),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections * 2),

                /// Confirm Update Button
                SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      prefsService.saveDeviceName(
                          connectedDevice.remoteId.toString(),
                          nameController.text.trim());
                      controller.writeThresholdDataToBLE(connectedDevice,
                          controller.sliderValue.value.toInt());
                      controller.readTreshholdDataFromBLE(connectedDevice);
                      // Return the updated name to Home screen
                      Get.back(result: nameController.text.trim());
                    },
                    child: Text('Apply',
                        style: AppStyles.buttonText.apply(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
