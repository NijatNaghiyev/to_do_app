import 'package:codelandia_to_do_riverpod/providers/today_todo_provider.dart';
import 'package:codelandia_to_do_riverpod/screens/notification_screen/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int todayToDo = ref.watch(todayTodoProvider);

    return ListTile(
      leading: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 40,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
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
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            iconSize: 26,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Badge(
              isLabelVisible: todayToDo > 0 ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
