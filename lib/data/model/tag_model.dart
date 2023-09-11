import 'package:hive_flutter/adapters.dart';

part 'tag_model.g.dart';

@HiveType(typeId: 1)
class TagModel {
  @HiveField(0)
  final String tagName;
  @HiveField(1)
  bool isAdded;

  TagModel({
    required this.tagName,
    this.isAdded = false,
  });
}
