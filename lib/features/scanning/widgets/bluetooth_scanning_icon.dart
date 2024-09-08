import 'package:flutter/material.dart';

class BluetoothScanningIcon extends StatelessWidget {
  const BluetoothScanningIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Animated outer container to simulate scanning effect
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 5),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Container(
              height: 180 + (20 * value),
              width: 180 + (20 * value),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white12
                    .withOpacity(1 - value), // Gradually fades out
              ),
            );
          },
          onEnd: () {
            // Restart the animation
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Rebuild to restart animation
            });
          },
        ),
        // Second largest container
        Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.white24,
          ),
        ),
        // Third largest container
        Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: Colors.white30,
          ),
        ),
        // Smallest container that holds the icon
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.white38, // Darkest color
          ),
        ),
        // The Bluetooth icon, perfectly centered
        const Icon(Icons.bluetooth, size: 100, color: Colors.white),
      ],
    );
  }
}
