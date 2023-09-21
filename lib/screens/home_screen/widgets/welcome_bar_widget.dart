import 'package:animations/animations.dart';
import 'package:codelandia_to_do_riverpod/screens/search_screen/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/today_todo_provider.dart';

class WelcomeBarWidget extends ConsumerWidget {
  const WelcomeBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var intTodayTodo = ref.watch(todayTodoProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              'Today: {}'.tr(context: context, args: [intTodayTodo.toString()]),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const Spacer(),
          OpenContainer(
            closedShape: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(26),
              ),
            ),
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
            openShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(26),
              ),
            ),
            openBuilder: (context, action) => const SearchScreen(),
          ),
        ],
      ),
    );
  }
}
