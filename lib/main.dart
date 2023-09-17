import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/hive/hive.dart';

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

  await EasyLocalization.ensureInitialized();

  await Alarm.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        startLocale: const Locale('en', 'US'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('az', 'AZ'),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
