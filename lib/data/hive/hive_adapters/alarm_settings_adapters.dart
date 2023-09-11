import 'package:alarm/model/alarm_settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmSettingsAdapter extends TypeAdapter<AlarmSettings> {
  @override
  final typeId = 4;

  @override
  void write(BinaryWriter writer, AlarmSettings obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.assetAudioPath)
      ..writeByte(3)
      ..write(obj.loopAudio)
      ..writeByte(4)
      ..write(obj.vibrate)
      ..writeByte(5)
      ..write(obj.volumeMax)
      ..writeByte(6)
      ..write(obj.fadeDuration)
      ..writeByte(7)
      ..write(obj.notificationTitle)
      ..writeByte(8)
      ..write(obj.notificationBody)
      ..writeByte(9)
      ..write(obj.enableNotificationOnKill)
      ..writeByte(10)
      ..write(obj.stopOnNotificationOpen);
  }

  @override
  AlarmSettings read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmSettings(
      id: fields[0] as int,
      dateTime: fields[1] as DateTime,
      assetAudioPath: fields[2] as String,
      loopAudio: fields[3] as bool,
      vibrate: fields[4] as bool,
      volumeMax: fields[5] as bool,
      fadeDuration: fields[6] as double,
      notificationTitle: fields[7] as String?,
      notificationBody: fields[8] as String?,
      enableNotificationOnKill: fields[9] as bool,
      stopOnNotificationOpen: fields[10] as bool,
    );
  }
}
