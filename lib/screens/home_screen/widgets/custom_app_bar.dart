import 'package:alarm/alarm.dart';
import 'package:codelandia_to_do_riverpod/providers/todo_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: IconButton(
        iconSize: 36,
        onPressed: () {},
        icon: const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      title: const Text(
        textAlign: TextAlign.center,
        'To Do List',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Stack(
        children: [
          IconButton(
            iconSize: 26,
            onPressed: () {
              ref.watch(todoListProvider).forEach((element) {
                print('${element.alarmSettings?.id}');
                print(Alarm.getAlarms().length);
              });
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
          const Positioned(
            top: 10,
            right: 10,
            child: Badge(),
          ),
        ],
      ),
    );
  }
}
