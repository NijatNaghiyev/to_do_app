import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/todo_model.dart';
import '../methods/todo_card_methods.dart';

class TodoCardIconButton extends ConsumerWidget {
  const TodoCardIconButton({
    super.key,
    required this.todoModel,
    required this.indexCard,
  });

  final TodoModel todoModel;
  final int indexCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iconSize: 30,
      onPressed: () {
        isDoneToDo(todoModel, indexCard, ref);
      },
      icon: Icon(
        todoModel.isDone ? Icons.check_circle : Icons.circle_outlined,
        color: Colors.black,
      ),
    );
  }
}
