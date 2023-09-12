import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'data/hive/hive.dart';
import 'data/hive/hive_adapters/alarm_settings_adapters.dart';
import 'data/model/tag_model.dart';
import 'data/model/todo_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initHive();

  // await Hive.initFlutter();
  // Hive
  //   ..registerAdapter(TagModelAdapter())
  //   ..registerAdapter(ColorAdapter())
  //   ..registerAdapter(TimeOfDayAdapter())
  //   ..registerAdapter(AlarmSettingsAdapter())
  //   ..registerAdapter(TodoModelAdapter());
  // await Hive.openBox('todoBox');

  await Alarm.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        datePickerTheme: const DatePickerThemeData(),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
