import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class TodoList extends StateNotifier<List<TodoModel>> {
  TodoList(ref)
      : super(
          Hive.box('box').get(
            'todos',
            defaultValue: <TodoModel>[],
          ).cast<TodoModel>(),
        );

  void add(TodoModel todoModel) {
    state = [todoModel, ...state];

    Hive.box('box').put('todos', state);
  }

  void isDone(TodoModel todoModel, int? index) {
    todoModel.isDone = !todoModel.isDone;
    state = [
      ...state
          .map((e) => state.indexOf(e) == index ? e = todoModel : e = e)
          .toList()
    ];

    Hive.box('box').put('todos', state);
  }

  void edit(TodoModel todoModel, int? index) {
    state = [
      ...state
          .map((e) => state.indexOf(e) == index ? e = todoModel : e = e)
          .toList()
    ];

    Hive.box('box').put('todos', state);
  }

  void remove(TodoModel todoModel) {
    state = state.where((element) => element != todoModel).toList();

    Hive.box('box').put('todos', state);
  }
}

final todoListProvider = StateNotifierProvider<TodoList, List<TodoModel>>(
  (ref) => TodoList(ref),
);
