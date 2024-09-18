import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ria_app/common/app_background/app_background.dart';
import 'package:ria_app/common/app_headers/app_header.dart';
import 'package:ria_app/features/home/controller/home_controller.dart';
import '../../../core/local_storage/shared_pref.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../common/app_models/data_recorded_model.dart';
import '../connected_device/controller/connection_controller.dart';

class HomeStoredData extends StatefulWidget {
  const HomeStoredData({super.key});

  @override
  State<HomeStoredData> createState() => _HomeStoredDataState();
}

class _HomeStoredDataState extends State<HomeStoredData> {
  SharedPrefsService prefsService = SharedPrefsService();
  HomeController controller = Get.find<HomeController>();
  ConnectionController conController = Get.find<ConnectionController>();
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        colors: const [
          Color.fromRGBO(75, 61, 133, 1),
          Color.fromRGBO(8, 12, 28, 1),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                AppHeader(
                  header: Obx(
                    () => Text(
                      conController.recordedBox.isNotEmpty
                          ? conController
                              .recordedBox[selectedIndex.value].deviceName
                          : 'No Data',
                      textAlign: TextAlign.center,
                      style: AppStyles.headlineMedium,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Device Current Reading (Reactive to the controller values)
                Obx(() => Text(
                      conController.recordedBox.isNotEmpty
                          ? '${conController.recordedBox[selectedIndex.value].currentCO2}ppm'
                          : 'No Data',
                      textAlign: TextAlign.center,
                      style: AppStyles.ubuntuHeadlineSmall,
                    )),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Returns Room CO2 Condition depends on Current Reading
                Obx(() => Container(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      height: 61,
                      decoration: BoxDecoration(
                        color: controller.airQualityColor.value,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        conController.recordedBox.isNotEmpty
                            ? controller.airQualityLabel.value
                            : 'No Data',
                        style: AppStyles.ubuntuHeadlineMedium,
                      ),
                    )),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Display recorded data from Hive using FutureBuilder
                FutureBuilder(
                  future: Hive.openBox('History'), // Opening Hive box
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        var box = snapshot.data as Box;
                        if (box.isNotEmpty) {
                          var data = box.get('Data${selectedIndex.value}');
                          if (data != null) {
                            RecordedData recordedData = data as RecordedData;
                            return Column(
                              children: [
                                Text(
                                  'Timestamp: ${recordedData.timestamp}',
                                  style: AppStyles.ubuntuHeadlineSmall,
                                ),
                                Text(
                                  'CO2 Level: ${recordedData.currentCO2} ppm',
                                  style: AppStyles.ubuntuHeadlineSmall,
                                ),
                                Text(
                                  'Device: ${recordedData.deviceName}',
                                  style: AppStyles.ubuntuHeadlineSmall,
                                ),
                              ],
                            );
                          } else {
                            return const Text('No recorded data available');
                          }
                        } else {
                          return const Text('No data available in the box');
                        }
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// Index Navigation
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (selectedIndex.value > 0) {
                            selectedIndex.value--;
                          }
                        },
                        icon: Obx(
                          () => Icon(Icons.arrow_back_ios,
                              color: selectedIndex.value <= 0
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                      ),
                      ...List.generate(
                        conController.recordedBox.length,
                        (index) => Obx(
                          () => GestureDetector(
                            onTap: () {
                              selectedIndex.value = index;
                            },
                            child: Row(
                              children: [
                                Text(
                                  '$index',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .apply(
                                          color: selectedIndex.value == index
                                              ? Colors.blue
                                              : Colors.white),
                                ),
                                const SizedBox(width: AppSizes.lg),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (selectedIndex.value <
                              conController.recordedBox.length - 1) {
                            selectedIndex.value++;
                          }
                        },
                        icon: Obx(
                          () => Icon(Icons.arrow_forward_ios,
                              color: selectedIndex.value ==
                                      conController.recordedBox.length - 1
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
