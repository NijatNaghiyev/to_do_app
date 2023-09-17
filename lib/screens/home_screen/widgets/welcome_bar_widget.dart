import 'package:animations/animations.dart';
import 'package:codelandia_to_do_riverpod/screens/search_screen/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeBarWidget extends ConsumerWidget {
  const WelcomeBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              'Welcome Back!'.tr(context: context),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
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
