import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../common/app_models/data_recorded_model.dart';
import '../../../core/hive_services/hive_services.dart';
import '../../../utils/popups/app_full_screen_loader.dart';
import '../../connecting/view/connecting.dart';
import '../../home/controller/home_controller.dart';
import '../../home/view/home.dart';
import '../../scan/presentation/view/scan.dart';
import '../../settings/controller/setting_controller.dart';

class ConnectionController extends GetxController {
  Timer? recordingTimer;
  var bluetoothState = BluetoothAdapterState.unknown.obs;
  RxBool isConnected = false.obs;
  BluetoothDevice? connectedDevice;
  RxList<RecordedData> recordedBox = <RecordedData>[].obs;
  late HiveServices hiveServices;
  late Box box;

  @override
  void onInit() {
    super.onInit();
    loadDataFromLocal();
  }

  Future<void> loadDataFromLocal() async {
    box = await Hive.openBox('History');
    hiveServices = HiveServices(box);
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    AppFullScreenLoader.openLoadingDialog(screen: const Connecting());

    try {
      if (isConnected.value) await disconnectDevice();

      await device.connect();
      connectedDevice = device;
      isConnected.value = true;

      AppFullScreenLoader.stopLoading();
      Get.to(Home(connectedDevice: connectedDevice!));

      HomeController homeController = Get.find<HomeController>();
      SettingController settingController = Get.find<SettingController>();
      homeController.readAndSubscribeToNotifications(connectedDevice!);
      homeController.readChartDataFromBLE(connectedDevice!);
      homeController.readWeeklyChartDataFromBLE(connectedDevice!);
      settingController.readTreshholdDataFromBLE(connectedDevice!);
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

  // Periodic data recording every 10 seconds
  void startRecording() {
    int i;
    if (box.isNotEmpty) {
      i = box.values.length;
    } else {
      i = recordedBox.length;
    }

    recordingTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      var homeController = Get.find<HomeController>();
      RecordedData data = RecordedData(
        timestamp: DateTime.now(),
        currentCO2: homeController.currentReading.value,
        co2_7d: homeController.chartDataweekly,
        co2_24h: homeController.chartData24h,
        deviceName: connectedDevice?.platformName ?? 'Unknown Device',
      );

      recordedBox.add(data);
      await hiveServices.storeData(data, i);
      i++;
    });
  }

  void stopRecording() {
    recordingTimer?.cancel();
  }
}
