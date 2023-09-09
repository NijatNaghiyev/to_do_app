import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var selectedTimeProvider = StateProvider<TimeOfDay?>(
  (ref) => null,
);
