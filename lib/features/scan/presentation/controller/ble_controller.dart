import 'dart:developer';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../../../../core/bluetooth/bluetooth.dart';
import '../../../../core/permissions/permissoins.dart';
import '../../../../utils/popups/app_full_screen_loader.dart';
import '../../../ble_device_list/view/device_list.dart';
import '../../../connecting/view/connecting.dart';
import '../../../home/view/home.dart';
import '../../../scanning/view/scanning.dart';
import '../view/scan.dart';

class BluetoothController extends GetxController {
  var bluetoothState = BluetoothAdapterState.unknown.obs;
  var scanResults = <ScanResult>[].obs;
  var filteredResults = <ScanResult>[].obs;
  RxBool isConnected = false.obs;
  BluetoothDevice? connectedDevice;
  String kServiceUUID = "0000ff10-0000-1000-8000-00805f9b34fb";
  String kCharUUID = "0000ff11-0000-1000-8000-00805f9b34fb";

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
      Get.snackbar(
        'Initialization Error',
        'Failed to initialize Bluetooth and Permissions',
      );
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
      Get.to(Home(connectedDevice: connectedDevice!));
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

  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  Future<void> readDataFromBLE(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        List<BluetoothService> services = await device.discoverServices();
        log(services.length.toString());

        for (BluetoothService service in services) {
          List<BluetoothCharacteristic> characteristics =
              service.characteristics;
          for (BluetoothCharacteristic characteristic in characteristics) {
            List<int> value = await characteristic.read();
            log('Characteristic value: $value');
          }
        }
      }
    } catch (e) {
      log("Something went wrong! $e");
    }
  }

  Future<void> writeDataToBLE(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        List<BluetoothService> services = await device.discoverServices();
        for (var service in services) {
          List<BluetoothCharacteristic> characteristics =
              service.characteristics;
          for (var characteristic in characteristics) {
            if (characteristic.properties.write) {
              await characteristic.write([0x12, 0x34]);
            }
          }
        }
      }
    } catch (e) {
      log("Something went wrong! $e");
    }
  }

  Future<void> subscribeToNotifications(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        List<BluetoothService> services = await device.discoverServices();
        for (var service in services) {
          for (var characteristic in service.characteristics) {
            if (characteristic.properties.notify) {
              await characteristic.setNotifyValue(true);
              characteristic.value.listen((value) {
                log('Received notification value: $value');
              });
            }
          }
        }
      }
    } catch (e) {
      log("Failed to subscribe to notifications: $e");
    }
  }
}
