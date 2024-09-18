import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_sizes.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.header,
    this.actionOnPressed,
    this.leadingOnPressed,
    this.haveAction = false,
    this.actionIcon,
  });
  final Widget header;
  final VoidCallback? actionOnPressed;
  final VoidCallback? leadingOnPressed;
  final bool haveAction;
  final IconData? actionIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSizes.sm, right: AppSizes.sm),
          child: haveAction
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: leadingOnPressed ?? () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: actionOnPressed,
                        icon: Icon(
                          actionIcon ?? Icons.settings_outlined,
                          size: 28,
                          color: Colors.white,
                        )),
                  ],
                )
              : Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
        ),
        header,
      ],
    );
  }
}
