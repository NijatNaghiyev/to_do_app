import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/hive/hive.dart';

class TodoList extends StateNotifier<List<TodoModel>> {
  TodoList(ref)
      : super(
          box.get(
            'todos',
            defaultValue: <TodoModel>[],
          ).cast<TodoModel>(),
        );

  /// [add] is a method that adds a [TodoModel] to the [state].
  void add(TodoModel todoModel) {
    state = [todoModel, ...state];

    box.put('todos', state);
  }

  /// [isDone] is a method that changes the [isDone] property of a [TodoModel] to the opposite of what it is.
  void isDone(TodoModel todoModel, int? index) {
    todoModel.isDone = !todoModel.isDone;

    state = [
      ...state
          .map((e) => state.indexOf(e) == index ? e = todoModel : e = e)
          .toList()
    ];

    box.put('todos', state);
  }

  /// [edit] is a method that changes the [TodoModel] to the new [TodoModel] passed in.
  void edit(TodoModel todoModel, int? index) {
    state = [
      ...state
          .map((e) => state.indexOf(e) == index ? e = todoModel : e = e)
          .toList()
    ];

    box.put('todos', state);
  }

  /// [remove] is a method that removes a [TodoModel] from the [state].
  void remove(TodoModel todoModel) {
    state = state.where((element) => element != todoModel).toList();

    box.put('todos', state);
  }
}

final todoListProvider = StateNotifierProvider<TodoList, List<TodoModel>>(
  (ref) => TodoList(ref),
);
