import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/colors.dart';
import '../../../providers/selected_color.dart';
import '../../../providers/selected_date.dart';
import '../../../providers/selected_time.dart';

void buildResetSaveData(WidgetRef ref) {
  ref.watch(selectedDateProvider.notifier).state = null;
  ref.watch(selectedColor.notifier).update((state) => state = kColorList[0]);
  ref.watch(selectedTimeProvider.notifier).state = null;
  ref.watch(tagsListProvider).forEach((element) => element.isAdded = false);
}
