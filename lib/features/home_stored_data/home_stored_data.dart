import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ria_app/common/app_background/app_background.dart';
import 'package:ria_app/common/app_headers/app_header.dart';
import 'package:ria_app/features/home/controller/home_controller.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_styles.dart';
import '../../common/app_models/data_recorded_model.dart';
import '../connected_device/controller/connection_controller.dart';
import '../home/widgets/day_hour_chart.dart';
import '../home/widgets/weekly_chart.dart';

class HomeStoredData extends StatefulWidget {
  const HomeStoredData({super.key});

  @override
  HomeStoredDataState createState() => HomeStoredDataState();
}

class HomeStoredDataState extends State<HomeStoredData> {
  @override
  void initState() {
    super.initState();

    if (homeController.historyBox.isNotEmpty) {
      homeController.updateAirQuality((homeController.historyBox
              .get('Data${selectedIndex.value}') as RecordedData)
          .currentCO2);

      selectedIndex.value = homeController.historyBox.length - 1;
    }
    setState(() {});
  }

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

                /// 24 Hours Readings Chart
                SizedBox(
                  height: 225,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Obx(() {
                    if (homeController.historyBox.isNotEmpty) {
                      List<int> values = (homeController.historyBox
                              .getAt(selectedIndex.value) as RecordedData)
                          .co2_24h;
                      return Chart24Hours(
                        yValues: values.map((e) => e.toDouble()).toList(),
                      );
                    } else {
                      return const Center(child: Text('No Data'));
                    }
                  }),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Weekly Readings Chart
                SizedBox(
                  height: 225,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Obx(() {
                    if (homeController.historyBox.isNotEmpty) {
                      List<int> weeklyValues = (homeController.historyBox
                              .getAt(selectedIndex.value) as RecordedData)
                          .co2_7d;
                      return WeeklyChart(
                        yValues: weeklyValues.map((e) => e.toDouble()).toList(),
                      );
                    } else {
                      return const Center(child: Text('No Data'));
                    }
                  }),
                ),

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
                                  homeController.updateAirQuality(
                                      (homeController.historyBox.get(
                                                  'Data${selectedIndex.value}')
                                              as RecordedData)
                                          .currentCO2);
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
                                  homeController.updateAirQuality(
                                      (homeController.historyBox.get(
                                                  'Data${selectedIndex.value}')
                                              as RecordedData)
                                          .currentCO2);
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
