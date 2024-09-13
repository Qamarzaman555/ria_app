import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../../utils/popups/app_full_screen_loader.dart';
import '../../connecting/view/connecting.dart';
import '../../home/controller/home_controller.dart';
import '../../home/view/home.dart';
import '../../scan/presentation/controller/scan_controller.dart';
import '../../scan/presentation/view/scan.dart';
import '../../settings/controller/setting_controller.dart';

class ConnectionController extends GetxController {
  var bluetoothState = BluetoothAdapterState.unknown.obs;

  RxBool isConnected = false.obs;
  BluetoothDevice? connectedDevice;
  Future<void> connectToDevice(BluetoothDevice device) async {
    AppFullScreenLoader.openLoadingDialog(screen: const Connecting());

    try {
      if (isConnected.value) {
        await disconnectDevice();
      }

      await device.connect();
      connectedDevice = device;
      isConnected.value = true;

      Get.find<ScanAndPersmissionController>().stopScan();

      AppFullScreenLoader.stopLoading();
      Get.to(Home(connectedDevice: connectedDevice!));

      Get.find<HomeController>()
          .readAndSubscribeToNotifications(connectedDevice!);
      Get.find<HomeController>().readChartDataFromBLE(connectedDevice!);
      Get.find<HomeController>().readWeeklyChartDataFromBLE(connectedDevice!);
      Get.find<SettingController>().readTreshholdDataFromBLE(connectedDevice!);
    } catch (e) {
      Get.snackbar('Connection Error', 'Failed to connect to device');
      AppFullScreenLoader.stopLoading();
    }
  }

  Future<void> disconnectDevice() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      isConnected.value = false;
      connectedDevice = null;
      Get.to(const Scan());
    }
  }
}
