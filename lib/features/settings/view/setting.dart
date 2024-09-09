import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ria_app/common/app_headers/app_header.dart';

import '../../../common/app_background/app_background.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../controller/setting_controller.dart';

class Setting extends StatelessWidget {
  const Setting({super.key, required this.connectedDevice});
  final BluetoothDevice connectedDevice;

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final SettingController sliderController = Get.find();
    return Scaffold(
      body: AppBackground(
        colors: const [
          Color.fromRGBO(75, 61, 133, 1),
          Color.fromRGBO(8, 12, 28, 1),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace),
          child: Column(
            children: [
              AppHeader(
                header: Text('Settings',
                    textAlign: TextAlign.center,
                    style: AppStyles.headlineMedium),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text("Set Device Name", style: AppStyles.ubuntuHeadlineSmall),
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * 0.7,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      connectedDevice.platformName,
                      style: AppStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              Text('Set Alert Threshold', style: AppStyles.ubuntuHeadlineSmall),
              Obx(() => Text(
                  '${sliderController.sliderValue.value.toStringAsFixed(0)}ppm',
                  style: AppStyles.ubuntuHeadlineLarge)),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.35,
                child: RotatedBox(
                  quarterTurns: 3, // Rotate by 90 degrees
                  child: Obx(() => Slider(
                        value: sliderController.sliderValue.value,
                        onChanged: (value) {
                          sliderController.updateSliderValue(value);
                        },
                        min: 500,
                        max: 3000,
                        activeColor: const Color.fromRGBO(196, 196, 196, 1),
                        inactiveColor: const Color.fromRGBO(133, 133, 133, 1),
                      )),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              SizedBox(
                height: 60,
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Apply',
                      style: AppStyles.buttonText.apply(color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
