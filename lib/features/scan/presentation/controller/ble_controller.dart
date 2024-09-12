import 'dart:developer';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../../../../core/bluetooth/bluetooth.dart';
import '../../../../core/permissions/permissoins.dart';
import '../../../../utils/popups/app_full_screen_loader.dart';
import '../../../ble_device_list/view/device_list.dart';
import '../../../scanning/view/scanning.dart';

class ScanAndPersmissionController extends GetxController {
  var bluetoothState = BluetoothAdapterState.unknown.obs;
  var scanResults = <ScanResult>[].obs;
  var filteredResults = <ScanResult>[].obs;

  RxString co2Level = ''.obs;

  @override
  void onInit() {
    super.onInit();
    BluetoothManager.initBluetoothState();
    _initializeBluetooth();
  }

  Future<void> _initializeBluetooth() async {
    bool permissionsGranted = await Permissions.requestPermissions();
    bool locationEnabled = await Permissions.enableLocationService();
    bool bluetoothEnabled = await BluetoothManager.enableBluetooth();

    if (permissionsGranted && locationEnabled && bluetoothEnabled) {
      _checkBluetoothState();
    } else {
      _initializeBluetooth();
    }
  }

  void _checkBluetoothState() {
    FlutterBluePlus.adapterState.listen((state) {
      bluetoothState.value = state;
    });
  }

  Future<void> scanForDevices() async {
    if (await Permissions.enableLocationService()) {
      AppFullScreenLoader.openLoadingDialog(screen: const Scanning());

      FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

      FlutterBluePlus.scanResults.listen((results) {
        scanResults.value = results;
        filteredResults.assignAll(
          scanResults.where((check) => check.device.platformName.isNotEmpty),
        );
      });

      log(filteredResults.length.toString());

      await Future.delayed(const Duration(seconds: 4));
      AppFullScreenLoader.stopLoading();
      Get.to(const DeviceListScreen());
    } else {
      Get.snackbar(
        'Permission Denied',
        'Location permission is required to scan for devices',
      );
      AppFullScreenLoader.stopLoading();
    }
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }
}
