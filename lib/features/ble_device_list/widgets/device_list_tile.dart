import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';

class DeviceListTile extends StatelessWidget {
  const DeviceListTile({
    super.key,
    required this.device,
  });

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        height: 50,
        width: MediaQuery.sizeOf(context).width * 80,
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                device.platformName.isEmpty
                    ? 'Unknown Device'
                    : device.platformName,
                textAlign: TextAlign.start,
                style: AppStyles.labelLarge),
          ],
        ));
  }
}
