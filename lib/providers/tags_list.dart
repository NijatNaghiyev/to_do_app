import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../data/model/tag_model.dart';

class TagNotifier extends StateNotifier<List<TagModel>> {
  TagNotifier()
      : super(
          Hive.box('todoBox').get(
            'tags',
            defaultValue: <TagModel>[],
          ).cast<TagModel>(),
        );

  void newToDo() {
    for (var element in state) {
      element.isAdded = false;
    }
  }

  void addTag(String tagName) {
    state = [...state, TagModel(tagName: '#$tagName')];

    Hive.box('todoBox').put('tags', state);
  }

  void removeTag(TagModel tagModel) {
    state = state.where((element) => element != tagModel).toList();

    Hive.box('todoBox').put('tags', state);
  }
}

var tagsListProvider = StateNotifierProvider<TagNotifier, List<TagModel>>(
  (ref) => TagNotifier(),
);
