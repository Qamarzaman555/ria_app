// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_recorded_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordedDataAdapter extends TypeAdapter<RecordedData> {
  @override
  final int typeId = 0;

  @override
  RecordedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordedData(
      timestamp: fields[0] as DateTime,
      deviceName: fields[1] as String,
      currentCO2: fields[2] as int,
      co2_7d: (fields[3] as List).cast<int>(),
      co2_24h: (fields[4] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecordedData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.deviceName)
      ..writeByte(2)
      ..write(obj.currentCO2)
      ..writeByte(3)
      ..write(obj.co2_7d)
      ..writeByte(4)
      ..write(obj.co2_24h);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
