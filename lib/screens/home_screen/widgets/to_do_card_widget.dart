import 'package:alarm/alarm.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/todo_list_provider.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/tags_on_card.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/new_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../constant/sized_box.dart';

class ToDoCardWidget extends ConsumerWidget {
  const ToDoCardWidget({
    super.key,
    required this.todoModel,
    required this.indexCard,
  });
  final int indexCard;
  final TodoModel todoModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteToDo() {
      ref.watch(todoListProvider.notifier).remove(todoModel);
      if (todoModel.alarmSettings != null) {
        Alarm.stop(todoModel.alarmSettings!.id);
      }
    }

    DateFormat dateFormat = DateFormat('dd MMMM yyyy');

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      child: Padding(
        key: ValueKey(todoModel.isDone),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Slidable(
          key: ValueKey(todoModel.id),
          endActionPane: ActionPane(
            dismissible: DismissiblePane(
              onDismissed: () {
                deleteToDo();
              },
            ),
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                onPressed: (context) {
                  deleteToDo();
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            key: ValueKey(todoModel.id),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: todoModel.isDone
                ? todoModel.color.withOpacity(0.25)
                : todoModel.color,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TagsOnCard(indexCard: indexCard),
                          ),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            iconSize: 34,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return NewTodo(
                                      title: 'Edit To Do',
                                      todoModel: todoModel,
                                      index: indexCard,
                                    );
                                  },
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit_note,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      todoModel.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  if (todoModel.description != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        todoModel.description!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              if (todoModel.deadline != null)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.black,
                                    ),
                                    kSizedBoxW10,
                                    Text(
                                      dateFormat.format(todoModel.deadline!),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              kSizedBoxH10,
                              if (todoModel.alarm != null)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.black,
                                    ),
                                    kSizedBoxW10,
                                    Text(
                                      '${todoModel.alarm!.hour}:${todoModel.alarm!.minute}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 30,
                          onPressed: () {
                            ref
                                .watch(todoListProvider.notifier)
                                .isDone(todoModel, indexCard);

                            if (todoModel.alarmSettings != null) {
                              todoModel.isDone
                                  ? Alarm.stop(todoModel.alarmSettings!.id)
                                  : Alarm.set(
                                      alarmSettings: todoModel.alarmSettings!);
                            }
                          },
                          icon: Icon(
                            todoModel.isDone
                                ? Icons.check_circle_outline
                                : Icons.circle_outlined,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
