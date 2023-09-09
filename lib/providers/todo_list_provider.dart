import 'package:codelandia_to_do_riverpod/data/model/tag_model.dart';
import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/colors.dart';

class TodoList extends StateNotifier<List<TodoModel>> {
  TodoList(ref)
      : super(<TodoModel>[
          TodoModel(
            title: 'Test dwadad dawdad dataTest dwadad dawdad datadddd',
            description: 'This is a description',
            tags: [
              TagModel(tagName: '#Work'),
            ],
            color: kColorList[1],
            deadline: DateTime.now(),
          ),
          TodoModel(
            title: 'Test dwadad dawdad data',
            tags: [
              TagModel(tagName: '#Home'),
            ],
            color: kColorList[3],
            deadline: DateTime.now(),
            alarm: TimeOfDay(hour: 20, minute: 14),
          ),
          TodoModel(
              title: 'Test dwadad dawdad data',
              description: 'This is a description',
              color: kColorList[6],
              tags: [
                TagModel(tagName: '#Home'),
                TagModel(tagName: '#Work'),
              ]),
        ]);

  void add(TodoModel todoModel) {
    state = [todoModel, ...state];
  }

  void remove(TodoModel todoModel) {
    state = state.where((element) => element != todoModel).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoList, List<TodoModel>>(
  (ref) => TodoList(ref),
);
