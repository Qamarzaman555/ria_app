import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BleDeviceViewModel {
  Rx<BleDeviceViewState> state;
  BleDeviceViewModel({required this.state});
  void setDevice(BluetoothDevice device) {
    state.value = state.value.copyWith(device: device);
  }

  void setScannedDevices(List<ScanResult> scannedDevices) {
    state.value = state.value.copyWith(scannedDevices: scannedDevices);
  }

  void setNotifyChars(List<BluetoothCharacteristic> notifyChars) {
    state.value = state.value.copyWith(notifyChars: notifyChars);
  }

  void setServices(List<BluetoothService> services) {
    state.value = state.value.copyWith(services: services);
  }

  // void setDeviceData(DeviceDataModel deviceData) {
  //   state.value = state.value.copyWith(deviceData: deviceData);
  // }

  void setReadValues(Map<String, List> readValues) {
    state.value = state.value.copyWith(readingFromDevice: readValues);
  }
}

class BleDeviceViewState {
  final BluetoothDevice? device;
  final List<ScanResult> scannedDevices;
  final List<BluetoothCharacteristic> notifyChars;
  final List<BluetoothService> services;
  // final DeviceDataModel deviceData;
  final Map<String, List> readingFromDevice;
  const BleDeviceViewState(
      {required this.device,
      required this.notifyChars,
      required this.scannedDevices,
      required this.services,
      // required this.deviceData,
      required this.readingFromDevice});
  BleDeviceViewState copyWith(
          {BluetoothDevice? device,
          List<ScanResult>? scannedDevices,
          List<BluetoothCharacteristic>? notifyChars,
          List<BluetoothService>? services,
          // DeviceDataModel? deviceData,
          Map<String, List>? readingFromDevice,
          bool? isConnected}) =>
      BleDeviceViewState(
          device: device ?? this.device,
          notifyChars: notifyChars ?? this.notifyChars,
          scannedDevices: scannedDevices ?? this.scannedDevices,
          services: services ?? this.services,
          // deviceData: deviceData ?? this.deviceData,
          readingFromDevice: readingFromDevice ?? this.readingFromDevice);
}
