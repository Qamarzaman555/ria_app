import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../../core/decode_data/decode_data.dart';
import '../../../core/encode_data/encode_data.dart';
// import '../../../core/encode_data/encode_data.dart';

class SettingController extends GetxController {
  String serviceUUID = "00002523-1212-efde-2523-785feabcd223";
  String charUUIDco2Thres =
      "00002527-1212-efde-2523-785feabcd223"; // Current CO2 treshold
  List<int> value = <int>[].obs;
  final DecodeRead _decoder = DecodeRead();
  final EncodeWrite _encoder = EncodeWrite();

  // Observable value for slider
  RxDouble sliderValue = 500.0.obs;
  RxList<int> thresholdValue = <int>[].obs;

  // Method to update the slider value
  void updateSliderValue(int value) {
    sliderValue.value = value.toDouble();
    log(sliderValue.value.toString());
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
        value = await targetCharacteristic.read();
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

  // Method to write threshold data to BLE characteristic
  Future<void> writeThresholdDataToBLE(
      BluetoothDevice device, int newValue) async {
    try {
      if (device.isConnected) {
        List<BluetoothService> services = await device.discoverServices();
        log("Total Services: ${services.length}");

        // Filter for the service with the matching UUID
        BluetoothService? targetService = services.firstWhere(
          (service) => service.uuid.toString() == serviceUUID,
        );

        log("Found target service with UUID: $serviceUUID");

        // Filter for the characteristic with the matching UUID
        BluetoothCharacteristic? targetCharacteristic =
            targetService.characteristics.firstWhere(
          (characteristic) =>
              characteristic.uuid.toString() == charUUIDco2Thres,
        );

        log("Found target characteristic with UUID: $charUUIDco2Thres");

        // Encode the new value using the encoder
        List<int> encodedValue = _encoder.uInt16L(newValue.toString());
        log("Encoded value to write: $encodedValue");

        // Write the encoded value to the characteristic
        await targetCharacteristic.write(encodedValue, withoutResponse: false);
        log('Successfully wrote new threshold value to characteristic.');
      }
    } catch (e) {
      log("Failed to write data! $e");
    }
  }
}
