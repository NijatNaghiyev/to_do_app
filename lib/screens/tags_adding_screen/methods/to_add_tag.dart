import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/tags_list.dart';

TextEditingController tagsEditingController = TextEditingController();

void toAddTag(WidgetRef ref) {
  if (tagsEditingController.text.isNotEmpty) {
    ref.read(tagsListProvider.notifier).addTag(
          tagsEditingController.text.trim(),
        );
  }
  tagsEditingController.clear();

  FocusManager.instance.primaryFocus?.unfocus();
}
