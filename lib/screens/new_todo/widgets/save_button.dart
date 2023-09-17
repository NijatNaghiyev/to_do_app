import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function() saveToDo;
  const SaveButton({super.key, required this.saveToDo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
            onPressed: saveToDo,
            child: Text(
              'Save'.tr(context: context),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
