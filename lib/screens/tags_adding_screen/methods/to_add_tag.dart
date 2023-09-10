import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/tags_list.dart';

TextEditingController textEditingController = TextEditingController();

void toAddTag(WidgetRef ref) {
  if (textEditingController.text.isNotEmpty) {
    ref.read(tagsListProvider.notifier).addTag(
          textEditingController.text.trim(),
        );
  }
  textEditingController.clear();

  FocusManager.instance.primaryFocus?.unfocus();
}
