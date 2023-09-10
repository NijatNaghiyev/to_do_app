// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/tags_on_card.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/new_todo_sceen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant/sized_box.dart';

class ToDoCardWidget extends StatelessWidget {
  const ToDoCardWidget({
    super.key,
    required this.todoModel,
    required this.indexCard,
  });
  final int indexCard;
  final TodoModel todoModel;
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        key: ValueKey(todoModel.id),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: todoModel.color,
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
                  style: TextStyle(
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
                    style: TextStyle(
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
                                  style: TextStyle(
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
                                  style: TextStyle(
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
                      iconSize: 30,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.circle_outlined,
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
    );
  }
}
