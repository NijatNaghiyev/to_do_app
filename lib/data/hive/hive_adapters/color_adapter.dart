import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final typeId = 3;

  @override
  Color read(BinaryReader reader) => Color(reader.readUint32());

  @override
  void write(BinaryWriter writer, Color obj) => writer.writeUint32(obj.value);
}
