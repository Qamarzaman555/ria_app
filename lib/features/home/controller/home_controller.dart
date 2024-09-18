import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../core/decode_data/decode_data.dart';

class HomeController extends GetxController {
  RxInt currentReading = 0.obs;
  RxString airQualityLabel = 'Good'.obs;
  Rx<Color> airQualityColor = Colors.green.obs;
  RxList<int> chartData24h = <int>[].obs;
  RxList<int> chartDataweekly = <int>[].obs;
  late Box historyBox;

  @override
  void onInit() {
    super.onInit();
    _openBox();
  }

  final String serviceUUID = "00002523-1212-efde-2523-785feabcd223";
  final String charUUIDCO2 =
      "00002524-1212-efde-2523-785feabcd223"; // Current CO2 level
  final String charUUIDCO2_24h =
      "00002525-1212-efde-2523-785feabcd223"; // 24h CO2 levels
  final String charUUIDCO2_7d =
      "00002526-1212-efde-2523-785feabcd223"; // 7d CO2 levels

  final DecodeRead _decoder = DecodeRead();

  Future<void> _openBox() async {
    historyBox = await Hive.openBox('History');
  }

  // Function to determine air quality and corresponding color
  void updateAirQuality(int reading) {
    if (reading < 800) {
      airQualityLabel.value = 'Good';
      airQualityColor.value = Colors.green;
    } else if (reading >= 800 && reading < 1200) {
      airQualityLabel.value = 'Reasonable';
      airQualityColor.value = Colors.lightBlue;
    } else if (reading >= 1200 && reading < 2000) {
      airQualityLabel.value = 'Poor';
      airQualityColor.value = Colors.yellow;
    } else if (reading >= 2000 && reading < 3000) {
      airQualityLabel.value = 'Bad';
      airQualityColor.value = Colors.orange;
    } else {
      airQualityLabel.value = 'Very Bad';
      airQualityColor.value = Colors.red;
    }
  }

  Future<void> readAndSubscribeToNotifications(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        // Discover services
        List<BluetoothService> services = await device.discoverServices();
        debugPrint("Total Services: ${services.length}");

        // Filter for the service with the matching UUID
        BluetoothService? targetService = services.firstWhere(
          (service) => service.uuid.toString() == serviceUUID,
        );
        debugPrint("Found target service with UUID: $serviceUUID");

        // Filter for the characteristic with the matching UUID
        BluetoothCharacteristic? targetCharacteristic =
            targetService.characteristics.firstWhere(
          (characteristic) => characteristic.uuid.toString() == charUUIDCO2,
        );
        debugPrint("Found target characteristic with UUID: $charUUIDCO2");

        // Read the value from the characteristic
        List<int> value = await targetCharacteristic.read();
        debugPrint('Characteristic value: $value');

        // Use the uInt16B method from DecodeRead class to decode the value
        List<int> decodedValue = _decoder.uInt16L(value);
        if (decodedValue.isNotEmpty) {
          currentReading.value = decodedValue.first;
        }

        // Update air quality based on the reading
        updateAirQuality(currentReading.value);

        // Subscribe to notifications if the characteristic supports it
        if (targetCharacteristic.properties.notify) {
          await targetCharacteristic.setNotifyValue(true);
          targetCharacteristic.onValueReceived.listen((value) {
            log('Received notification value: $value');

            // Optionally decode the notification value if needed
            List<int> decodedNotification = _decoder.uInt16L(value);
            if (decodedNotification.isNotEmpty) {
              currentReading.value = decodedNotification.first;
            }

            // Update air quality based on the notification
            updateAirQuality(currentReading.value);
          });
          log('Subscribed to notifications for characteristic: $charUUIDCO2');
        } else {
          log('Characteristic does not support notifications');
        }
      }
    } catch (e) {
      debugPrint("Something went wrong! $e");
    }
  }

  Future<void> readChartDataFromBLE(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        List<BluetoothService> services = await device.discoverServices();
        debugPrint("Total Services: ${services.length}");

        // Filter for the service with the matching UUID
        BluetoothService? targetService = services.firstWhere(
          (service) => service.uuid.toString() == serviceUUID,
        );

        debugPrint("Found target service with UUID: $serviceUUID");

        // Filter for the characteristic with the matching UUID
        BluetoothCharacteristic? targetCharacteristic =
            targetService.characteristics.firstWhere(
          (characteristic) => characteristic.uuid.toString() == charUUIDCO2_24h,
        );

        debugPrint("Found target characteristic with UUID: $charUUIDCO2_24h");

        // Read the value from the characteristic
        List<int> value = await targetCharacteristic.read();
        debugPrint('Characteristic value: $value');

        // Use the uInt16B method from DecodeRead class to decode the value
        chartData24h.value = _decoder.uInt16L(value);

        for (var data in chartData24h) {
          log('$data');
        }
      }
    } catch (e) {
      debugPrint("Something went wrong! $e");
    }
  }

  Future<void> readWeeklyChartDataFromBLE(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        List<BluetoothService> services = await device.discoverServices();
        debugPrint("Total Services: ${services.length}");

        // Filter for the service with the matching UUID
        BluetoothService? targetService = services.firstWhere(
          (service) => service.uuid.toString() == serviceUUID,
        );

        debugPrint("Found target service with UUID: $serviceUUID");

        // Filter for the characteristic with the matching UUID
        BluetoothCharacteristic? targetCharacteristic =
            targetService.characteristics.firstWhere(
          (characteristic) => characteristic.uuid.toString() == charUUIDCO2_7d,
        );

        debugPrint("Found target characteristic with UUID: $charUUIDCO2_7d");

        // Read the value from the characteristic
        List<int> value = await targetCharacteristic.read();
        debugPrint('Characteristic value: $value');

        // Use the uInt16B method from DecodeRead class to decode the value
        chartDataweekly.value = _decoder.uInt16L(value);

        for (var data in chartDataweekly) {
          log('$data');
        }
      }
    } catch (e) {
      debugPrint("Something went wrong! $e");
    }
  }

  // Formatter
  DateFormat formatter = DateFormat('dd MMM, yy hh:mm:ss a');
}
