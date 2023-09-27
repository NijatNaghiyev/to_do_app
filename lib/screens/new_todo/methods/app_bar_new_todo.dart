import 'package:codelandia_to_do_riverpod/screens/new_todo/methods/show_dialog_new_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AppBar buildAppBarNewTodo(BuildContext context, WidgetRef ref, String title) {
  return AppBar(
    leading: IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        buildShowDialogNewTodo(context, ref);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
