import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
