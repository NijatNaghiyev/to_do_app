import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/hive/hive.dart';

var selectedLanguageProvider = StateProvider(
  (ref) => box.get(
    'selectedLanguage',
    defaultValue: 'en_US',
  ),
);
