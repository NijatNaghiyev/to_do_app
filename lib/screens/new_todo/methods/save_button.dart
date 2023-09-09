import 'package:flutter/material.dart';

Row buildSaveButton(Function() saveToDo) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Colors.black,
          ),
        ),
        onPressed: saveToDo,
        child: const Text('Save'),
      ),
    ],
  );
}
