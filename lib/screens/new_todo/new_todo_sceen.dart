import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/constant/colors.dart';
import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/selected_color.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/home_screen.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/ToDoForm.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/tags_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/tag_model.dart';
import '../../providers/form_providers.dart';
import '../../providers/selected_date.dart';
import '../../providers/selected_time.dart';
import '../../providers/todo_list_provider.dart';
import 'methods/app_bar_new_todo.dart';
import 'methods/build_color.dart';
import 'methods/build_reset_save_data.dart';
import 'methods/save_button.dart';

class NewTodo extends ConsumerStatefulWidget {
  final TodoModel? todoModel;
  final String title;

  const NewTodo({
    super.key,
    this.todoModel,
    required this.title,
  });

  @override
  ConsumerState<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends ConsumerState<NewTodo> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  late bool creating;

  String title = '';
  String? description;
  Color color = kColorList[0];
  List<TagModel?> tags = [];
  DateTime? deadline;
  TimeOfDay? alarm;
  AlarmSettings? alarmSettings;

  /// Save To Do
  Future<void> saveToDo() async {
    final todoList = ref.watch(todoListProvider.notifier);
    title = ref.watch(titleProvider.notifier).state;
    description = ref.watch(descriptionProvider);

    /// Validate form
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      color = ref.watch(selectedColor.notifier).state;
      tags = ref
          .watch(tagsListProvider)
          .where((element) => element.isAdded == true)
          .toList();

      setAlarm();

      /// Add new To Do
      todoList.add(
        TodoModel(
          title: title,
          description: description,
          color: color,
          tags: tags,
          deadline: ref.watch(selectedDateProvider.notifier).state,
          alarm: ref.watch(selectedTimeProvider.notifier).state,
          alarmSettings: alarmSettings,
        ),
      );

      _formKey.currentState!.reset();

      buildResetSaveData(ref);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  /// Alarm Settings
  AlarmSettings buildAlarmSettings() {
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.todoModel?.alarmSettings!.id;

    DateTime dateTime = DateTime(
      ref.watch(selectedDateProvider)!.year,
      ref.watch(selectedDateProvider)!.month,
      ref.watch(selectedDateProvider)!.day,
      ref.watch(selectedTimeProvider)!.hour,
      ref.watch(selectedTimeProvider)!.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    alarmSettings = AlarmSettings(
      id: id!,
      dateTime: dateTime,
      loopAudio: true,
      vibrate: true,
      volumeMax: true,
      notificationTitle: !creating ? widget.todoModel!.title : title,
      notificationBody: !creating ? widget.todoModel!.description : description,
      assetAudioPath: 'assets/alarms/marimba.mp3',
      stopOnNotificationOpen: true,
      enableNotificationOnKill: true,
    );
    return alarmSettings!;
  }

  void setAlarm() {
    if (ref.watch(selectedDateProvider) != null &&
        ref.watch(selectedTimeProvider) != null) {
      buildAlarmSettings();
      if (alarmSettings != null) {
        Alarm.set(alarmSettings: alarmSettings!);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    creating = widget.todoModel == null;
  }

  @override
  Widget build(BuildContext context) {
    var selectedDate = ref.watch(selectedDateProvider);
    var selectedTime = ref.watch(selectedTimeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarNewTodo(context, ref, widget.title),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToDoForm(
              formKey: _formKey,
            ),
            kSizedBoxH20,
            Card(
              margin: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              child: SwitchListTile.adaptive(
                secondary: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit_calendar),
                  ],
                ),
                title: const Text('Date'),
                subtitle: selectedDate == null
                    ? const Text('No date selected')
                    : Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                value: selectedDate != null,
                onChanged: (value) {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(
                        days: 7,
                      ),
                    ),
                    lastDate: DateTime.now().add(
                      const Duration(
                        days: 365,
                      ),
                    ),
                  ).then(
                    (value) =>
                        ref.read(selectedDateProvider.notifier).state = value,
                  );
                  deadline = selectedDate;
                },
              ),
            ),
            kSizedBoxH20,
            Card(
              margin: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              child: SwitchListTile.adaptive(
                secondary: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm_add),
                  ],
                ),
                title: const Text('Alarm'),
                subtitle: selectedTime == null
                    ? const Text('No time selected')
                    : Text(
                        '${selectedTime.hour}:${selectedTime.minute}',
                      ),
                value: selectedTime != null,
                onChanged: (value) async {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then(
                    (value) {
                      if (value != null && selectedDate == null) {
                        ref
                            .read(selectedDateProvider.notifier)
                            .update((state) => state = DateTime.now());
                      }
                      ref.read(selectedTimeProvider.notifier).state = value;
                      alarm = value;
                    },
                  );
                },
              ),
            ),
            kSizedBoxH20,
            const TagsWidget(),
            kSizedBoxH20,
            buildColor(ref, color),
            kSizedBoxH20,
            buildSaveButton(saveToDo),
          ],
        ),
      ),
    );
  }
}
