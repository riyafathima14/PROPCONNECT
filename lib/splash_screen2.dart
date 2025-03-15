import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:propconnect/signin_page1.dart';


class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(child: Image.asset('assets/images/propconnectlogo1.png')),
      nextScreen: SigninPage1(), 
      backgroundColor: Color(0XFF204ECF),
      splashIconSize: 250, 
      animationDuration: const Duration(milliseconds: 1500),
      splashTransition: SplashTransition.fadeTransition, 
    );
  }
}
