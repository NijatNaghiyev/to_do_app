import 'package:animations/animations.dart';
import 'package:codelandia_to_do_riverpod/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant/sized_box.dart';

class WelcomeBarWidget extends StatelessWidget {
  const WelcomeBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              kSizedBoxH10,
              Text(
                'Here\'s Update Today.',
                style: TextStyle(
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
