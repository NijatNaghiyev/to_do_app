import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/data/model/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

Uuid uuid = const Uuid();

@HiveType(typeId: 2)
class TodoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final Color color;
  @HiveField(3)
  final List<TagModel> tags;
  @HiveField(4)
  final DateTime? deadline;
  @HiveField(5)
  final TimeOfDay? alarm;
  @HiveField(6)
  final AlarmSettings? alarmSettings;
  @HiveField(7)
  bool isDone;
  @HiveField(8)
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
