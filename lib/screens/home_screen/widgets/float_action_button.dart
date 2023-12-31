import 'package:animations/animations.dart';
import 'package:codelandia_to_do_riverpod/providers/tags_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/sized_box.dart';
import '../../new_todo/new_todo_screen.dart';

class FloatActionButton extends ConsumerWidget {
  const FloatActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tagsListProvider.notifier).newToDo();
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      openBuilder: (context, action) => NewTodo(
        todoModel: null,
        appBarTitle: 'New To Do'.tr(context: context),
      ),
      closedBuilder: (context, action) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              kSizedBoxW10,
              Text(
                'Add To Do'.tr(context: context),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
