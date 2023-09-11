import 'package:codelandia_to_do_riverpod/data/model/tag_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/todo_model.dart';
import 'hive_adapters/alarm_settings_adapters.dart';

void initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TagModelAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(AlarmSettingsAdapter());
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox('box');
}
