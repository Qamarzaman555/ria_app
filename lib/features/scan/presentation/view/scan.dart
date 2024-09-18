import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_background/app_background.dart';
import '../../../../utils/app_sizes.dart';
import '../../../../utils/app_styles.dart';
import '../../../home/controller/home_controller.dart';
import '../../../home_stored_data/home_stored_data.dart';
import '../controller/scan_controller.dart';
import '../widgets/footer_button_widget.dart';
import '../widgets/header_widget.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanAndPersmissionController controller = Get.find();
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      /// -- Linear Gradient Background
      body: AppBackground(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// App Header
              const HeaderWidget(),
              const Spacer(),

              /// Center BluetoothIcon
              const Icon(Icons.bluetooth, size: 100, color: Colors.white),
              const Spacer(),

              /// Footer (Text & Scan Button)
              Column(
                children: [
                  FooterButtunWidget(controller: controller),

                  /// Hive Local Storage text button which will show the data stored in hive storage
                  TextButton(
                      onPressed: () {
                        if (homeController.historyBox.isEmpty) {
                          // Show toast
                          Get.snackbar('No data found',
                              'There is no recorded data available.');
                        } else {
                          // Navigate to playback page
                          Get.to(() => const HomeStoredData());
                        }
                      },
                      child:
                          Text("Local Storage", style: AppStyles.bodyMedium)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
