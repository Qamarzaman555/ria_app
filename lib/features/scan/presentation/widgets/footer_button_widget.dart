import 'package:flutter/material.dart';

import '../../../../utils/app_styles.dart';
import '../controller/scan_controller.dart';

class FooterButtunWidget extends StatelessWidget {
  const FooterButtunWidget({
    super.key,
    required this.controller,
  });

  final ScanAndPersmissionController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Scan for nearby Ria Smart devices", style: AppStyles.bodyMedium),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              /// Scans for devices
              controller.scanForDevices();
            },
            child: Text("Scan", style: AppStyles.buttonText),
          ),
        ),
      ],
    );
  }
}
