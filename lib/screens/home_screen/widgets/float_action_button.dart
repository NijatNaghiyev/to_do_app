import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../constant/sized_box.dart';
import '../../new_todo/new_todo_screen.dart';

class FloatActionButton extends StatelessWidget {
  const FloatActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      openBuilder: (context, action) => const NewTodo(
        todoModel: null,
        title: 'New To Do',
      ),
      closedBuilder: (context, action) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 50,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              kSizedBoxW10,
              Text(
                'Add To Do',
                textAlign: TextAlign.center,
                style: TextStyle(
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
