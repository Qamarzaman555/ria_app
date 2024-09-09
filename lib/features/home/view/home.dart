import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ria_app/common/app_background/app_background.dart';
import 'package:ria_app/common/app_headers/app_header.dart';
import 'package:ria_app/features/home/widgets/day_hour_chart.dart';
import 'package:ria_app/features/home/widgets/weekly_chart.dart';

import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../settings/view/setting.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.connectedDevice});
  final BluetoothDevice connectedDevice;

  @override
  Widget build(BuildContext context) {
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
                haveAction: true,
                actionOnPressed: () =>
                    Get.to(Setting(connectedDevice: connectedDevice)),
                header: Text(connectedDevice.platformName,
                    textAlign: TextAlign.center,
                    style: AppStyles.headlineMedium),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text('600ppm',
                  textAlign: TextAlign.center,
                  style: AppStyles.ubuntuHeadlineSmall),
              const SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                width: 225,
                height: 61,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(56, 160, 67, 1)),
                    onPressed: () {},
                    child: Text('Good', style: AppStyles.ubuntuHeadlineMedium)),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              SizedBox(
                height: 200,
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: const Chart24Hours(),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              SizedBox(
                height: 200,
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: const WeeklyChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
