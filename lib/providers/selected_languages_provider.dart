import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

var selectedLanguageProvider = StateProvider(
  (ref) => Hive.box('todoBox').get(
    'selectedLanguage',
    defaultValue: 'en_US',
  ),
);
