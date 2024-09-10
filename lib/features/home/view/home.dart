import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ria_app/common/app_background/app_background.dart';
import 'package:ria_app/common/app_headers/app_header.dart';
import 'package:ria_app/features/home/widgets/day_hour_chart.dart';
import 'package:ria_app/features/home/widgets/weekly_chart.dart';

import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../scan/presentation/controller/ble_controller.dart';
import '../../settings/view/setting.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.connectedDevice});
  final BluetoothDevice connectedDevice;

  @override
  Widget build(BuildContext context) {
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
                  haveAction: true,
                  actionOnPressed: () =>
                      Get.to(Setting(connectedDevice: connectedDevice)),
                  header: Text(connectedDevice.platformName,
                      textAlign: TextAlign.center,
                      style: AppStyles.headlineMedium),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Device Current Reading
                Text('600ppm',
                    textAlign: TextAlign.center,
                    style: AppStyles.ubuntuHeadlineSmall),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Returns Room CO2 Condition depends on Current Reading
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  height: 61,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(56, 160, 67, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Good',
                    style: AppStyles.ubuntuHeadlineMedium,
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwSections),

                /// 24 Hours Readings Chart
                SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: const Chart24Hours(),
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Weekly Readings Chart
                SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: const WeeklyChart(),
                ),

                const SizedBox(height: AppSizes.spaceBtwSections),

                SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: ElevatedButton(
                      onPressed: () => Get.find<BluetoothController>()
                          .readDataFromBLE(connectedDevice),
                      child: const Text('Read Data')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
