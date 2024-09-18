import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ria_app/common/app_background/app_background.dart';
import 'package:ria_app/common/app_headers/app_header.dart';
import 'package:ria_app/features/home/controller/home_controller.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../common/app_models/data_recorded_model.dart';
import '../connected_device/controller/connection_controller.dart';

class HomeStoredData extends StatefulWidget {
  const HomeStoredData({super.key});

  @override
  HomeStoredDataState createState() => HomeStoredDataState();
}

class HomeStoredDataState extends State<HomeStoredData> {
  final HomeController homeController = Get.find<HomeController>();
  final ConnectionController conController = Get.find<ConnectionController>();
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        colors: const [Color(0xFF4B3D85), Color(0xFF080C1C)],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Obx(() => AppHeader(
                      header: Text(
                        homeController.historyBox.isNotEmpty
                            ? (homeController.historyBox
                                        .get('Data${selectedIndex.value}')
                                    as RecordedData)
                                .deviceName
                            : 'No Data',
                        textAlign: TextAlign.center,
                        style: AppStyles.headlineMedium,
                      ),
                    )),
                const SizedBox(height: AppSizes.spaceBtwItems),

                // Current CO2 Reading
                Obx(() => Text(
                      homeController.historyBox.isNotEmpty
                          ? '${(homeController.historyBox.get('Data${selectedIndex.value}') as RecordedData).currentCO2} ppm'
                          : 'No Data',
                      style: AppStyles.ubuntuHeadlineSmall,
                    )),
                const SizedBox(height: AppSizes.spaceBtwItems),

                // Air Quality Container
                Obx(() => Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 61,
                      decoration: BoxDecoration(
                        color: homeController.airQualityColor.value,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        homeController.airQualityLabel.value,
                        style: AppStyles.ubuntuHeadlineMedium,
                      ),
                    )),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // Display Hive recorded data
                homeController.historyBox.isNotEmpty
                    ? Obx(
                        () => Column(
                          children: [
                            Text(
                              'Timestamp: ${(homeController.historyBox.get('Data${selectedIndex.value}') as RecordedData).timestamp}',
                              style: AppStyles.ubuntuHeadlineSmall,
                            ),
                            Text(
                              'CO2 Level: ${(homeController.historyBox.get('Data${selectedIndex.value}') as RecordedData).currentCO2} ppm',
                              style: AppStyles.ubuntuHeadlineSmall,
                            ),
                            Text(
                              'Device: ${(homeController.historyBox.get('Data${selectedIndex.value}') as RecordedData).deviceName}',
                              style: AppStyles.ubuntuHeadlineSmall,
                            ),
                          ],
                        ),
                      )
                    : const Text('No recorded data available'),
                const SizedBox(height: AppSizes.spaceBtwSections),

                // Index Navigation
                homeController.historyBox.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (selectedIndex.value > 0) {
                                  selectedIndex.value--;
                                }
                              },
                              icon: Obx(() => Icon(Icons.arrow_back_ios,
                                  color: selectedIndex.value <= 0
                                      ? Colors.grey
                                      : Colors.white)),
                            ),
                            Obx(
                              () => Text(
                                homeController.formatter.format((homeController
                                            .historyBox
                                            .get('Data${selectedIndex.value}')
                                        as RecordedData)
                                    .timestamp),
                                style: AppStyles.labelLarge,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (selectedIndex.value <
                                    homeController.historyBox.length - 1) {
                                  selectedIndex.value++;
                                }
                              },
                              icon: Obx(() => Icon(Icons.arrow_forward_ios,
                                  color: selectedIndex.value ==
                                          homeController.historyBox.length - 1
                                      ? Colors.grey
                                      : Colors.white)),
                            ),
                          ],
                        ),
                      )
                    : const Text('No data available'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
