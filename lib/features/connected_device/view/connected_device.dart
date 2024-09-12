import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_background/app_background.dart';
import '../../../common/app_headers/app_header.dart';
import '../../../utils/app_styles.dart';
import '../controller/connection_controller.dart';

class ConnectedDeviceScreen extends StatelessWidget {
  const ConnectedDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConnectionController controller = Get.find();
    return Scaffold(
      body: Center(
        child: AppBackground(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: AppHeader(
                      header: Text("Connected Device",
                          textAlign: TextAlign.center,
                          style: AppStyles.headlineMedium)),
                ),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.center,
                      'Connected to device ${controller.connectedDevice?.platformName}',
                      style: AppStyles.bodyLarge),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.disconnectDevice();
                    Get.back();
                  },
                  child: Text(
                    'Disconnect',
                    style: AppStyles.buttonText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
