import 'package:hive/hive.dart';

part 'data_recorded_model.g.dart';

@HiveType(typeId: 0)
class RecordedData extends HiveObject {
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final String deviceName;

  @HiveField(2)
  final int currentCO2;

  @HiveField(3)
  final List<int> co2_7d;

  @HiveField(4)
  final List<int> co2_24h;

  RecordedData({
    required this.timestamp,
    required this.deviceName,
    required this.currentCO2,
    required this.co2_7d,
    required this.co2_24h,
  });
}
