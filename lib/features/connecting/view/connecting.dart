import 'package:flutter/material.dart';

import '../../../common/app_background/app_background.dart';
import '../../../utils/app_styles.dart';

class Connecting extends StatelessWidget {
  const Connecting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- Linear Gradient Background
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 60),
          child:

              ///  Center Text
              Center(
            child: Text("Connecting...",
                style:
                    AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
