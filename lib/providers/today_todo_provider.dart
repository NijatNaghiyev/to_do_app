import 'package:codelandia_to_do_riverpod/providers/todo_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var todayTodoProvider = StateProvider<int>(
  (ref) {
    var todoList = ref.watch(todoListProvider);
    return todoList
        .where(
          (element) {
            return (element.deadline == null || element.isDone)
                ? false
                : (element.deadline!.isAfter(
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        23,
                        59,
                        59,
                        999,
                      ).subtract(const Duration(days: 1)),
                    ) &&
                    element.deadline!.isBefore(
                      DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        23,
                        59,
                        59,
                        999,
                      ),
                    ));
          },
        )
        .toList()
        .length;
  },
);
