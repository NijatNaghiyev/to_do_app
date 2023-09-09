import 'dart:ui';

import 'package:codelandia_to_do_riverpod/constant/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var selectedColor = StateProvider<Color>(
  (ref) => kColorList[0],
);
