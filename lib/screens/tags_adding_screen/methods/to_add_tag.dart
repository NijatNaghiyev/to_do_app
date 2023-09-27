import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/tags_list.dart';

void toAddTag(WidgetRef ref, TextEditingController tagsEditingController) {
  if (tagsEditingController.text.isNotEmpty) {
    ref.read(tagsListProvider.notifier).addTag(
          tagsEditingController.text.trim(),
        );
  }
  tagsEditingController.clear();

  FocusManager.instance.primaryFocus?.unfocus();
}
