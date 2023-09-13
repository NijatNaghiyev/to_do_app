import 'package:animations/animations.dart';
import 'package:codelandia_to_do_riverpod/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/sized_box.dart';
import '../../../providers/todo_list_provider.dart';

class WelcomeBarWidget extends ConsumerWidget {
  const WelcomeBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoList = ref.watch(todoListProvider);
    int todayToDo = todoList
        .where((element) {
          return (element.deadline == null || element.isDone)
              ? false
              : (element.deadline!.isAfter(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      23,
                      59,
                      59,
                      999,
                    ).subtract(const Duration(days: 1)),
                  ) &&
                  element.deadline!.isBefore(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      23,
                      59,
                      59,
                      999,
                    ),
                  ));
        })
        .toList()
        .length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              kSizedBoxH10,
              Text(
                'You\'ve $todayToDo To Do(s) Today.',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const Spacer(),
          OpenContainer(
            closedElevation: 0,
            transitionDuration: const Duration(milliseconds: 500),
            closedBuilder: (context, action) => const CircleAvatar(
              radius: 26,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
            openBuilder: (context, action) => const SearchScreen(),
          ),
        ],
      ),
    );
  }
}
