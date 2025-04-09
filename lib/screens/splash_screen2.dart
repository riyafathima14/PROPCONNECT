import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:propconnect/screens/signin_page1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:propconnect/screens/homepage.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  late Widget nextScreen = const SigninPage1(); // default to SigninPage1

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      setState(() {
        nextScreen = const HomePage(); // If logged in, go to HomePage
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(child: Image.asset('assets/images/propconnectlogo1.png')),
      nextScreen: nextScreen, // Use the dynamic nextScreen variable
      backgroundColor: const Color(0XFF204ECF),
      splashIconSize: 250,
      animationDuration: const Duration(milliseconds: 1500),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
