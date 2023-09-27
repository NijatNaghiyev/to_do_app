import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/todo_model.dart';
import '../../../providers/search_provider.dart';
import '../../../providers/todo_list_provider.dart';

/// [filterDefault] is a method that sets the [searchProvider] to an empty list.
void filterDefault(String value, WidgetRef ref) {
  if (value.trim().isEmpty) {
    ref.watch(searchProvider.notifier).update(
          (state) => [],
        );
  }
}

/// [filterTitle] is a method that filters the [todoListProvider] by the [value] passed in Titles.
void filterTitle(String value, WidgetRef ref) {
  filterDefault(value, ref);

  ref.watch(searchProvider.notifier).update(
        (state) => ref
            .watch(todoListProvider)
            .where(
              (element) => element.title.toLowerCase().contains(
                    value.toLowerCase().trim(),
                  ),
            )
            .toList(),
      );
}

/// [filterDescription] is a method that filters the [todoListProvider] by the [value] passed in Descriptions.
void filterDescription(String value, WidgetRef ref) {
  filterDefault(value, ref);

  ref.watch(searchProvider.notifier).update(
        (state) => ref
            .watch(todoListProvider)
            .where(
              (element) => element.description == null
                  ? false
                  : element.description!.toLowerCase().contains(
                        value.toLowerCase().trim(),
                      ),
            )
            .toList(),
      );
}

/// [filterTag] is a method that filters the [todoListProvider] by the [value] passed in Tags.
void filterTag(String value, WidgetRef ref) {
  filterDefault(value, ref);

  Set<TodoModel> setList = {};
  ref.watch(todoListProvider).forEach(
    (element) {
      for (var e in element.tags) {
        if (e.tagName.toLowerCase().contains(value.toLowerCase().trim())) {
          setList.add(element);
        }
      }
    },
  );
  ref.watch(searchProvider.notifier).update(
        (state) => setList.toList(),
      );
}

/// [filterAll] is a method that filters the [todoListProvider] by the [value] passed in All.
void filterAll(String value, WidgetRef ref) {
  filterDefault(value, ref);

  /// [boolFilterAll] is a method that returns a [bool] based on whether the [value] passed in is in the [TodoModel] or not.
  bool boolFilterAll(TodoModel element) {
    return (element.title.toLowerCase().contains(value.toLowerCase().trim()) ||
        (element.description == null
            ? false
            : element.description!.toLowerCase().contains(
                  value.toLowerCase().trim(),
                )) ||
        (element.tags.any(
          (element) => element.tagName.toLowerCase().contains(
                value.toLowerCase().trim(),
              ),
        )));
  }

  ref.watch(searchProvider.notifier).update((state) => ref
      .watch(todoListProvider)
      .where((element) => boolFilterAll(element))
      .toList());
}
