import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:propconnect/screens/splash_screen2.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/logogif.gif'), 
      nextScreen: SplashScreen2(), 
      backgroundColor: Colors.white,
      splashIconSize: 250, 
      animationDuration: const Duration(milliseconds: 1500),
      splashTransition: SplashTransition.fadeTransition, 
    );
  }
}
