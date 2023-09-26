import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/tags_on_card.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/todo_card_icon_button.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/new_todo_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constant/sized_box.dart';
import '../methods/todo_card_methods.dart';

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
                deleteToDo(todoModel, ref);
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
                  deleteToDo(todoModel, ref);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete'.tr(context: context),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                key: ValueKey(todoModel.id),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: todoModel.isDone
                    ? todoModel.color.withOpacity(0.1)
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
                              Visibility(
                                visible: todoModel.isDone ? false : true,
                                child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  iconSize: 34,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NewTodo(
                                            appBarTitle: 'Edit To Do',
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
                      if (todoModel.description != null &&
                          todoModel.description!.isNotEmpty)
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
                                    isVisibleDate(
                                      todoModel,
                                      ref,
                                    ),
                                  kSizedBoxH10,
                                  if (todoModel.alarm != null)
                                    isVisibleTime(
                                      todoModel,
                                    ),
                                ],
                              ),
                            ),
                            TodoCardIconButton(
                              todoModel: todoModel,
                              indexCard: indexCard,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// This is the code for the icon that appears when the deadline is passed
              if ((todoModel.deadline == null
                      ? false
                      : todoModel.deadline!.isBefore(
                          DateTime.now(),
                        )) &&
                  !todoModel.isDone)
                const Positioned(
                  top: -10,
                  right: -5,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FaIcon(
                      FontAwesomeIcons.calendarXmark,
                      color: Color(0xFFC9160C),
                    ),
                  ),
                ),

              /// This is the code for the icon that appears when the deadline is today
              if ((todoModel.deadline == null || todoModel.isDone)
                  ? false
                  : (todoModel.deadline!.isAfter(
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          23,
                          59,
                          59,
                          999,
                        ).subtract(
                          const Duration(days: 1),
                        ),
                      ) &&
                      todoModel.deadline!.isBefore(
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          23,
                          59,
                          59,
                          999,
                        ),
                      )))
                const Positioned(
                  top: -10,
                  right: -5,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FaIcon(
                      FontAwesomeIcons.calendar,
                      color: Color(0xFF1A8509),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
