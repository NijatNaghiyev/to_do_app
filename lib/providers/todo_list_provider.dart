import 'dart:developer';

import 'package:codelandia_to_do_riverpod/data/model/tag_model.dart';
import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/colors.dart';

class TodoList extends StateNotifier<List<TodoModel>> {
  TodoList(ref) : super(<TodoModel>[]);

  void add(TodoModel todoModel) {
    state = [todoModel, ...state];
  }

  void edit(TodoModel todoModel, int? index) {
    state = [
      ...state
          .map((e) => state.indexOf(e) == index ? e = todoModel : e = e)
          .toList()
    ];
  }

  void remove(TodoModel todoModel) {
    state = state.where((element) => element != todoModel).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoList, List<TodoModel>>(
  (ref) => TodoList(ref),
);
