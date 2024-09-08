import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';
import '../app_background/app_background.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(status,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              const SizedBox(height: 50),
              const Icon(Icons.bluetooth_disabled,
                  size: 100, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
