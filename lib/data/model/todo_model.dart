import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/data/model/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class TodoModel {
  final String title;
  final String? description;
  final Color color;
  final List<TagModel?> tags;
  final DateTime? deadline;
  final TimeOfDay? alarm;
  final AlarmSettings? alarmSettings;
  final bool isDone;
  final String id;

  TodoModel({
    required this.title,
    this.description,
    required this.color,
    this.tags = const [],
    this.deadline,
    this.alarm,
    this.alarmSettings,
    this.isDone = false,
  }) : id = uuid.v4();
}
