import 'dart:async';
import 'dart:core';

import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/constant/colors.dart';
import 'package:codelandia_to_do_riverpod/constant/sized_box.dart';
import 'package:codelandia_to_do_riverpod/data/model/todo_model.dart';
import 'package:codelandia_to_do_riverpod/providers/selected_color.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/home_screen.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/ToDoForm.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/color_widget.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/date_picker_theme.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/save_button.dart';
import 'package:codelandia_to_do_riverpod/screens/new_todo/widgets/tags_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/tag_model.dart';
import '../../generated/assets.dart';
import '../../providers/form_providers.dart';
import '../../providers/isCreating_provider.dart';
import '../../providers/selected_date.dart';
import '../../providers/selected_languages_provider.dart';
import '../../providers/selected_time.dart';
import '../../providers/todo_list_provider.dart';
import 'methods/app_bar_new_todo.dart';
import 'methods/build_reset_save_data.dart';

class NewTodo extends ConsumerStatefulWidget {
  final int? index;
  final TodoModel? todoModel;
  final String appBarTitle;

  const NewTodo({
    super.key,
    this.index,
    this.todoModel,
    required this.appBarTitle,
  });

  @override
  ConsumerState<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends ConsumerState<NewTodo> {
  var timeFormat = DateFormat.Hm();

  bool loading = false;

  late bool creating;

  String title = '';
  String? description;
  Color color = kColorList[0];
  List<TagModel> tags = [];
  DateTime? deadline;
  TimeOfDay? alarm;
  AlarmSettings? alarmSettings;

  /// Save To Do
  Future<void> saveToDo() async {
    final todoList = ref.watch(todoListProvider.notifier);

    /// Validate form
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      title = ref.watch(titleProvider);
      description = ref.watch(descriptionProvider);
      color = ref.watch(selectedColor.notifier).state;
      tags = ref
          .read(tagsListProvider)
          .where((element) => element.isAdded == true)
          .toList();

      /// Set Alarm
      setAlarm();

      /// Add new To Do
      if (creating) {
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
      } else {
        todoList.edit(
          TodoModel(
            title: title,
            description: description,
            color: color,
            tags: tags,
            deadline: ref.watch(selectedDateProvider.notifier).state,
            alarm: ref.watch(selectedTimeProvider.notifier).state,
            alarmSettings: alarmSettings,
          ),
          widget.index,
        );
      }

      formKey.currentState!.reset();

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
        : widget.todoModel?.alarmSettings?.id ??
            DateTime.now().millisecondsSinceEpoch % 100000;

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
      id: id,
      dateTime: dateTime,
      assetAudioPath: Assets.alarmsMarimba,
      loopAudio: true,
      vibrate: true,
      volumeMax: true,
      fadeDuration: 0.0,
      notificationTitle: title,
      notificationBody: description ?? 'Alarm',
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

    /// Check if creating or editing
    creating = widget.todoModel == null;
    Timer(Duration.zero, () {
      ref.watch(isCreatingProvider.notifier).update((state) => creating);
      if (!creating) {
        ref
            .watch(selectedColor.notifier)
            .update((state) => widget.todoModel!.color);

        ref.watch(selectedDateProvider.notifier).update(
              (state) => widget.todoModel!.deadline,
            );

        ref.watch(selectedTimeProvider.notifier).update(
              (state) => widget.todoModel!.alarm,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedDate = ref.watch(selectedDateProvider);
    var selectedTime = ref.watch(selectedTimeProvider);
    var selectedLanguage = ref.watch(selectedLanguageProvider);
    DateFormat dateFormat = DateFormat('dd MMMM yyyy', selectedLanguage);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarNewTodo(context, ref, widget.appBarTitle),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToDoForm(
              todoModel: widget.todoModel,
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
                activeTrackColor: Colors.grey,
                activeColor: Colors.black,
                secondary: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit_calendar),
                  ],
                ),
                title: Text('Date'.tr(context: context)),
                subtitle: selectedDate == null
                    ? Text('No date selected'.tr(context: context))
                    : Text(
                        dateFormat.format(selectedDate),
                      ),
                value: selectedDate != null,
                onChanged: (value) {
                  showDatePicker(
                    builder: (context, child) {
                      return PickerThemeCustom(
                        child: child,
                      );
                    },
                    locale: Localizations.localeOf(context),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(
                        days: 365 * 5,
                      ),
                    ),
                  ).then(
                    (value) {
                      if (value == null) {
                        ref
                            .watch(selectedTimeProvider.notifier)
                            .update((state) => null);
                      }
                      return ref.read(selectedDateProvider.notifier).state =
                          value;
                    },
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
                activeTrackColor: Colors.grey,
                activeColor: Colors.black,
                secondary: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm_add),
                  ],
                ),
                title: Text('Alarm'.tr(context: context)),
                subtitle: selectedTime == null
                    ? Text('No time selected'.tr(context: context))
                    : Text(
                        timeFormat.format(
                          DateTime(
                            0,
                            0,
                            0,
                            selectedTime.hour,
                            selectedTime.minute,
                          ),
                        ),
                      ),
                value: selectedTime != null,
                onChanged: (value) async {
                  showTimePicker(
                    initialEntryMode: TimePickerEntryMode.input,
                    builder: (context, Widget? child) {
                      return PickerThemeCustom(
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: true,
                          ),
                          child: child!,
                        ),
                      );
                    },
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then(
                    (value) {
                      if (value != null &&
                          (selectedDate == null ||
                              selectedDate.isBefore(DateTime.now()))) {
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
            TagsWidget(
              todoModel: widget.todoModel,
            ),
            kSizedBoxH20,
            const ColorWidget(),
            kSizedBoxH20,
            SaveButton(
              saveToDo: saveToDo,
            ),
          ],
        ),
      ),
    );
  }
}
