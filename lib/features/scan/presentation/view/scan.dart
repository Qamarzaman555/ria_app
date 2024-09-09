import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_background/app_background.dart';
import '../controller/ble_controller.dart';
import '../widgets/footer_button_widget.dart';
import '../widgets/header_widget.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
    return Scaffold(
      /// -- Linear Gradient Background
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// App Header
            const HeaderWidget(),

            /// Center BluetoothIcon
            const Icon(Icons.bluetooth, size: 100, color: Colors.white),

            /// Footer (Text & Scan Button)
            FooterButtunWidget(controller: controller),
          ],
        ),
      ),
    );
  }
}
