import 'package:get/get.dart';

import '../features/ble_device_list/view/device_list.dart';
import '../features/blueooth_check/view/bluetooth_check.dart';
import '../features/connected_device/view/connected_device.dart';
import 'routes.dart';

class RoutePages {
  static const String bluetoothCheckScreen = '/';

  static final routes = [
    GetPage(
        name: Routes.bluetoothCheckScreen,
        page: () => const BluetoothCheckScreen()),
    GetPage(
        name: Routes.deviceListScreen, page: () => const DeviceListScreen()),
    GetPage(
        name: Routes.deviceConnection,
        page: () => const ConnectedDeviceScreen()),
  ];
}
