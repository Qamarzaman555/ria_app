import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/ble_controller.dart';
import '../../../ble_device_list/view/device_list.dart';

class FooterButtunWidget extends StatelessWidget {
  const FooterButtunWidget({
    super.key,
    required this.controller,
  });

  final BluetoothController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Scan for nearby Ria Smart devices",
            style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              controller.scanForDevices();
              Get.to(const DeviceListScreen());
            },
            child: Text("Scan",
                style: GoogleFonts.ubuntu(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue)),
          ),
        ),
      ],
    );
  }
}
