import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/constant/colors.dart';
import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/selected_color.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/home_screen.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/tags_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/tag_model.dart';
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

  late bool creating;

  String title = '';
  String? description;
  Color color = kColorList[0];
  List<TagModel?> tags = [];
  DateTime? deadline;
  TimeOfDay? alarm;
  AlarmSettings? alarmSettings;

  Future<void> saveToDo() async {
    final todoList = ref.watch(todoListProvider.notifier);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      color = ref.watch(selectedColor.notifier).state;
      tags = ref
          .watch(tagsListProvider)
          .where((element) => element.isAdded == true)
          .toList();
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

  // AlarmSettings? alarmSettingsFunc() {
  //   if (ref.watch(selectedDateProvider.notifier).state != null) {
  //     alarmSettings = AlarmSettings(
  //       id: DateTime.now().millisecondsSinceEpoch % 100000,
  //       dateTime: ref.watch(selectedDateProvider.notifier).state!.add(
  //             Duration(
  //               hours: ref.watch(selectedTimeProvider.notifier).state!.hour,
  //               minutes: ref.watch(selectedTimeProvider.notifier).state!.minute,
  //             ),
  //           ),
  //       assetAudioPath: 'assets/alarms/ringtone-58761.mp3',
  //       loopAudio: true,
  //       vibrate: true,
  //       volumeMax: true,
  //       fadeDuration: 3.0,
  //       notificationTitle: 'This is the title',
  //       notificationBody: 'This is the body',
  //       enableNotificationOnKill: true,
  //     );
  //     return alarmSettings;
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    var selectedDate = ref.watch(selectedDateProvider);
    var selectedTime = ref.watch(selectedTimeProvider);
    var todoList = ref.watch(todoListProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarNewTodo(context, ref, widget.title),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.length > 50) {
                          return 'Must be between 2 and 50 characters.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        title = newValue!;
                      },
                      maxLines: null,
                      maxLength: 50,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: const Text('Title*'),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'Enter your title',
                      ),
                    ),
                    kSizedBoxH20,
                    TextFormField(
                      onSaved: (newValue) {
                        description = newValue;
                      },
                      maxLines: null,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: const Text('Description'),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'Enter your description',
                      ),
                    ),
                  ],
                ),
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
                      return ref.read(selectedTimeProvider.notifier).state =
                          value;
                    },
                  );
                },
              ),
            ),
            kSizedBoxH20,
            TagsWidget(),
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
