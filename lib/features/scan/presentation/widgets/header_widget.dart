import 'package:flutter/material.dart';

import '../../../../utils/app_images.dart';
import '../../../../utils/app_styles.dart';

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
        Text("Wirelism", style: AppStyles.headlineStyle),
      ],
    );
  }
}
