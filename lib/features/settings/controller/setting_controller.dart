import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../../core/decode_data/decode_data.dart';
import '../../../core/encode_data/encode_data.dart';

class SettingController extends GetxController {
  String serviceUUID = "00002523-1212-efde-2523-785feabcd223";
  String charUUIDco2Thres =
      "00002527-1212-efde-2523-785feabcd223"; // Current CO2 treshold
  final DecodeRead _decoder = DecodeRead();
  final EncodeWrite _encoder = EncodeWrite();

  // Observable value for slider
  RxDouble sliderValue = 500.0.obs;
  RxList<double> thresholdValue = <double>[].obs;

  // Method to update the slider value
  void updateSliderValue(double value) {
    sliderValue.value = value;
  }

  Future<void> readTreshholdDataFromBLE(BluetoothDevice device) async {
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
          (characteristic) =>
              characteristic.uuid.toString() == charUUIDco2Thres,
        );

        debugPrint("Found target characteristic with UUID: $charUUIDco2Thres");

        // Read the value from the characteristic
        List<int> value = await targetCharacteristic.read();
        debugPrint('Characteristic value: $value');

        // Use the uInt16B method from DecodeRead class to decode the value
        List<int> decodedValue = _decoder.uInt16L(value);
        log('Threshold Value is: $decodedValue');
        if (decodedValue.isNotEmpty) {
          sliderValue.value = decodedValue.first.toDouble();
        }
      }
    } catch (e) {
      debugPrint("Something went wrong! $e");
    }
  }

  Future<void> writeThresholdDataToBLE(BluetoothDevice device) async {
    try {
      if (device.isConnected) {
        // Discover services
        List<BluetoothService> services = await device.discoverServices();

        // Filter for the service with the matching UUID
        BluetoothService? targetService = services.firstWhere(
          (service) => service.uuid.toString() == serviceUUID,
        );

        debugPrint("Found target service with UUID: $serviceUUID");

        // Filter for the characteristic with the matching UUID
        BluetoothCharacteristic? targetCharacteristic =
            targetService.characteristics.firstWhere(
          (characteristic) =>
              characteristic.uuid.toString() == charUUIDco2Thres,
        );

        debugPrint("Found target characteristic with UUID: $charUUIDco2Thres");

        // Convert the threshold value to bytes (adjust based on the data format)
        List<int> valueToWrite = _encoder.uInt16L(sliderValue.toString());
        debugPrint('Value to write: $valueToWrite');

        // Write the value to the characteristic
        await targetCharacteristic.write(valueToWrite);
        debugPrint(
            'Successfully wrote value: $valueToWrite to characteristic: $charUUIDco2Thres');
      }
    } catch (e) {
      debugPrint("Failed to write to characteristic! $e");
    }
  }
}
