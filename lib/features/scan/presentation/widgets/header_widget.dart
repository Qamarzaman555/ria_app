import 'package:flutter/material.dart';

import '../../../../utils/app_images.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.wirelismLogo),
        const SizedBox(width: 4),
        Text("Wirelism",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ],
    );
  }
}
