import 'package:codelandia_to_do_riverpod/providers/todo_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var expiredProvider = StateProvider<int>(
  (ref) {
    var todoList = ref.watch(todoListProvider);

    return todoList
        .where((todoModel) =>
            (todoModel.deadline == null
                ? false
                : todoModel.deadline!.isBefore(
                    DateTime.now().subtract(
                      const Duration(days: 1),
                    ),
                  )) &&
            !todoModel.isDone)
        .toList()
        .length;
  },
);
