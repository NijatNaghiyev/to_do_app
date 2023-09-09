import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/tag_model.dart';

class TagNotifier extends StateNotifier<List<TagModel>> {
  TagNotifier()
      : super(<TagModel>[
          TagModel(tagName: '#Home'),
          TagModel(tagName: '#School'),
          TagModel(tagName: '#Lifestyle'),
          TagModel(tagName: '#Urgent'),
          TagModel(tagName: '#Important'),
          TagModel(tagName: '#Work'),
        ]);

  void addTag(String tagName) {
    state = [...state, TagModel(tagName: '#$tagName')];
  }

  void removeTag(TagModel tagModel) {
    state = state.where((element) => element != tagModel).toList();
  }
}

var tagsListProvider = StateNotifierProvider<TagNotifier, List<TagModel>>(
  (ref) => TagNotifier(),
);
