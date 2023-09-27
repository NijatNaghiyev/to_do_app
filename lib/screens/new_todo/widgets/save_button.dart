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
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              backgroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
            onPressed: saveToDo,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Save'.tr(context: context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
