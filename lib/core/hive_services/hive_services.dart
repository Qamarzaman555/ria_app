import 'dart:developer';

import 'package:hive/hive.dart';

import '../../common/app_models/data_recorded_model.dart';

class DataRepository {
  final Box _box;

  DataRepository(this._box);

  Future<void> storeData(RecordedData data, int index) async {
    await _box.put('Data$index', data);
    log('Data stored at key Data$index');
  }

  RecordedData? getData(int index) {
    return _box.get('Data$index') as RecordedData?;
  }

  int get length => _box.length;
}
