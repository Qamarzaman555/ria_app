import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_background/app_background.dart';
import '../../../common/app_headers/app_header.dart';
import '../../scan/presentation/controller/ble_controller.dart';

class ConnectedDeviceScreen extends StatelessWidget {
  const ConnectedDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BluetoothController controller = Get.find();
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
                          style: GoogleFonts.ubuntu(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white))),
                ),
                Expanded(
                  child: Text(
                      textAlign: TextAlign.center,
                      'Connected to device ${controller.connectedDevice?.platformName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: Colors.white, fontWeightDelta: 2)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.disconnectDevice();
                    Get.back();
                  },
                  child: const Text('Disconnect'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
