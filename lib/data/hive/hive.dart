import 'package:codelandia_to_do_riverpod/data/model/tag_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/todo_model.dart';
import 'hive_adapters/alarm_settings_adapters.dart';

late final box;

void initHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(TagModelAdapter())
    ..registerAdapter(ColorAdapter())
    ..registerAdapter(TimeOfDayAdapter())
    ..registerAdapter(AlarmSettingsAdapter())
    ..registerAdapter(TodoModelAdapter());
  await Hive.openBox('todoBox');
}
