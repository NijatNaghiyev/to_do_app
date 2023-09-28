import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/widgets/to_do_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../providers/expired_provider.dart';
import '../../providers/today_todo_provider.dart';
import '../../providers/todo_list_provider.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoList = ref.watch(todoListProvider);
    int todayToDo = ref.watch(todayTodoProvider);
    int expiredToDo = ref.watch(expiredProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Notification'.tr(context: context),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todayToDo <= 0 && expiredToDo <= 0)
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/notify.svg',
                      ),
                    ),
                  ),
                ],
              ),
            Visibility(
              visible: todayToDo > 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Today'.tr(context: context),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            for (var todoModel in todoList)
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
                        ).subtract(const Duration(days: 1)),
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
                ToDoCardWidget(
                  todoModel: todoModel,
                  indexCard: todoList.indexOf(todoModel),
                ),
            kSizedBoxH20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: expiredToDo > 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Expired'.tr(context: context),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                for (var todoModel in todoList)
                  if (((todoModel.deadline == null || todoModel.isDone)
                      ? false
                      : todoModel.deadline!.isBefore(
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
                        )))
                    ToDoCardWidget(
                      todoModel: todoModel,
                      indexCard: todoList.indexOf(todoModel),
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
