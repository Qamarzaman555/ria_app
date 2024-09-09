import 'package:flutter/material.dart';

import '../../../common/app_background/app_background.dart';
import '../../../utils/app_styles.dart';
import '../../scan/presentation/widgets/header_widget.dart';
import '../widgets/bluetooth_scanning_icon.dart';
import '../../../common/app_headers/app_header.dart';

class Scanning extends StatelessWidget {
  const Scanning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: AppHeader(
                  header: HeaderWidget(),
                ),
              ),
              const Expanded(
                flex: 4,
                child: BluetoothScanningIcon(),
              ),
              Text("Scanning...", style: AppStyles.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
