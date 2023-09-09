import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';

import '../../ring_screen/ring_screen.dart';

Future<void> navigateToRingScreen(
    BuildContext context, AlarmSettings alarmSettings) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AlarmRingScreen(alarmSettings: alarmSettings),
    ),
  );
}
