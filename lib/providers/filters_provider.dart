import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/todo_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/filter_button.dart';

var filterProvider = StateProvider<Filter>(
  (ref) => Filter.all,
);

var filterListProvider = StateProvider<List<TodoModel>>(
  (ref) {
    switch (ref.watch(filterProvider)) {
      case Filter.all:
        return ref.watch(todoListProvider);
      // [
      //   ...ref
      //       .watch(todoListProvider)
      //       .where((element) => !element.isDone)
      //       .toList(),
      //   ...ref
      //       .watch(todoListProvider)
      //       .where((element) => element.isDone)
      //       .toList(),
      // ]
      case Filter.ongoing:
        return ref
            .watch(todoListProvider)
            .where((element) => !element.isDone)
            .toList();
      case Filter.done:
        return ref
            .watch(todoListProvider)
            .where((element) => element.isDone)
            .toList();
      default:
        return [];
    }
  },
);
