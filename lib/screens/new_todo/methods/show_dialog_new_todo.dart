import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'build_reset_save_data.dart';

Future<void> buildShowDialogNewTodo(BuildContext context, WidgetRef ref) {
  return showAdaptiveDialog<void>(
    useRootNavigator: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog.adaptive(
        shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        title: Text('Discard'.tr(context: context)),
        content: Text('Do you want to discard this?'.tr(context: context)),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Discard'.tr(context: context),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              buildResetSaveData(ref);
              Navigator.pop(context);
              Navigator.pop(context);
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
            child: Text(
              'Cancel'.tr(context: context),
            ),
          ),
        ],
      );
    },
  );
}
