import 'dart:async';
import 'dart:developer';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../common/app_models/data_recorded_model.dart';
import '../../../utils/popups/app_full_screen_loader.dart';
import '../../connecting/view/connecting.dart';
import '../../home/controller/home_controller.dart';
import '../../home/view/home.dart';
import '../../scan/presentation/controller/scan_controller.dart';
import '../../scan/presentation/view/scan.dart';
import '../../settings/controller/setting_controller.dart';

class ConnectionController extends GetxController {
  Timer? recordingTimer;
  var bluetoothState = BluetoothAdapterState.unknown.obs;

  RxBool isConnected = false.obs;
  BluetoothDevice? connectedDevice;
  RxList<RecordedData> recordedBox = <RecordedData>[].obs;
  Box<dynamic>? box;

  @override
  onInit() {
    super.onInit();
    loadDataFromLocal();
  }

  loadDataFromLocal() async {
    box = await Hive.openBox('History');
  }

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
      startRecording();
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
      stopRecording();
      Get.to(const Scan());
    }
  }

  // Start the periodic recording every 10 seconds
  startRecording() async {
    int i = 0;

    recordingTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      // Create new RecordedData object with current values
      RecordedData data = RecordedData(
        timestamp: DateTime.now(),
        currentCO2: Get.find<HomeController>().currentReading.value,
        co2_7d: Get.find<HomeController>().chartDataweekly,
        co2_24h: Get.find<HomeController>().chartData24h,
        deviceName: connectedDevice!.platformName,
      );

      // Save data to both Hive Box and in-memory list (if needed)
      recordedBox.add(data);
      await box!.put('Data$i', data); // Store data with unique key Data{i}

      log('Recorded data added: $data');
      log('Data stored at key Data$i');

      i++; // Increment index for the next storage
    });
  }

  // Stop recording data
  void stopRecording() {
    recordingTimer?.cancel();
  }
}
