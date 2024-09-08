import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_sizes.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.header,
  });
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSizes.sm),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Colors.white,
                )),
          ),
        ),
        header,
      ],
    );
  }
}
