import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../constant/sized_box.dart';
import '../../../data/model/todo_model.dart';
import '../../../providers/selected_languages_provider.dart';
import '../../../providers/todo_list_provider.dart';

void deleteToDo(TodoModel todoModel, WidgetRef ref) {
  ref.watch(todoListProvider.notifier).remove(todoModel);
  if (todoModel.alarmSettings != null) {
    Alarm.stop(todoModel.alarmSettings!.id);
  }
}

void isDoneToDo(TodoModel todoModel, int indexCard, WidgetRef ref) {
  void isBeforeNow() {
    if (DateTime(
      todoModel.deadline!.year,
      todoModel.deadline!.month,
      todoModel.deadline!.day,
      todoModel.alarm!.hour,
      todoModel.alarm!.minute,
      0,
      0,
    ).isAfter(DateTime.now())) {
      Alarm.set(alarmSettings: todoModel.alarmSettings!);
    }
  }

  ref.watch(todoListProvider.notifier).isDone(todoModel, indexCard);

  if (todoModel.alarmSettings != null) {
    todoModel.isDone ? Alarm.stop(todoModel.alarmSettings!.id) : isBeforeNow();
  }
}

Row isVisibleDate(TodoModel todoModel, WidgetRef ref) {
  var selectedLanguage = ref.watch(selectedLanguageProvider);
  DateFormat dateFormat = DateFormat('dd MMMM yyyy', selectedLanguage);

  return Row(
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
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Row isVisibleTime(TodoModel todoModel) {
  DateFormat timeFormat = DateFormat.Hm();

  return Row(
    children: [
      const Icon(
        Icons.alarm,
        color: Colors.black,
      ),
      kSizedBoxW10,
      Text(
        timeFormat.format(
          DateTime(
            0,
            0,
            0,
            todoModel.alarm!.hour,
            todoModel.alarm!.minute,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
