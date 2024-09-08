import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';

class AppFullScreenLoader {
  static void openLoadingDialog({required Widget screen}) {
    showDialog(
      context:
          Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside it
      useSafeArea: false,
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button

        child: Container(
          color: AppColors.light,
          width: double.infinity,
          height: double.infinity,
          child: screen,
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); // Close the dialog using the Navigator
  }
}
