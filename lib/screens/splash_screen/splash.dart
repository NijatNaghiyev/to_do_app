import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:codelandia_to_do_riverpod/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2500,
      splash: Lottie.asset(
        Assets.lottiesAnimationLmsxlbga,
      ),
      nextScreen: const HomeScreen(),
      centered: true,
      splashIconSize: 250,
      backgroundColor: Colors.black,
    );
  }
}
