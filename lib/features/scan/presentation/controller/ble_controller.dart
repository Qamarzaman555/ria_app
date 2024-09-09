import 'dart:developer';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../../../core/bluetooth/bluetooth.dart';
import '../../../../core/permissions/permissoins.dart';
import '../../../../utils/popups/app_full_screen_loader.dart';
import '../../../connecting/view/connecting.dart';
import '../../../home/view/home.dart';
import '../../../scanning/view/scanning.dart';
import '../../../connected_device/view/connected_device.dart';

class BluetoothController extends GetxController {
  var bluetoothState = BluetoothAdapterState.unknown.obs;
  var scanResults = <ScanResult>[].obs;
  var filteredResults = <ScanResult>[].obs;
  RxBool isConnected = false.obs;
  BluetoothDevice? connectedDevice;

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
      Get.snackbar('Initialization Error',
          'Failed to initialize Bluetooth and Permissions');
    }
  }

  void _checkBluetoothState() {
    FlutterBluePlus.adapterState.listen((state) {
      bluetoothState.value = state;
    });
  }

  Future<void> scanForDevices() async {
    if (await Permissions.enableLocationService()) {
      // Open the loading dialog
      AppFullScreenLoader.openLoadingDialog(screen: const Scanning());

      // Start scanning for devices
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

      // Listen to scan results
      FlutterBluePlus.scanResults.listen((results) {
        scanResults.value = results;
      });
      filteredResults.assignAll(
          scanResults.where((check) => check.device.platformName.isNotEmpty));

      log(filteredResults.length.toString());

      // Wait for 4 to 5 seconds to ensure the loader is visible
      await Future.delayed(const Duration(seconds: 4));

      // Stop the loading dialog
      AppFullScreenLoader.stopLoading();
    } else {
      // If location permission is not granted, show a snackbar and stop the loader
      Get.snackbar(
        'Permission Denied',
        'Location permission is required to scan for devices',
      );
      AppFullScreenLoader.stopLoading();
    }
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

      stopScan();

      AppFullScreenLoader.stopLoading();
      Get.to(const ConnectedDeviceScreen());
      Get.to(Home(connectedDevice: connectedDevice!));
    } catch (e) {
      Get.snackbar('Connection Error', 'Failed to connect to device');
      AppFullScreenLoader.stopLoading();
    }
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  Future<void> disconnectDevice() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      isConnected.value = false;
      connectedDevice = null;
    }
  }
}
