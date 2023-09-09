import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home_screen/home_screen.dart';
import 'build_reset_save_data.dart';

Future<void> buildShowDialogNewTodo(BuildContext context, WidgetRef ref) {
  return showAdaptiveDialog<void>(
    useRootNavigator: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog.adaptive(
        title: const Text('Discard'),
        content: const Text('Do you want to discard this?'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Discard',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              buildResetSaveData(ref);
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const HomeScreen(),
              //   ),
              // );
            },
          ),
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
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Cancel',
            ),
          ),
        ],
      );
    },
  );
}
