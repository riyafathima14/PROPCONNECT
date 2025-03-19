import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:propconnect/createaccount_screen.dart';
//import 'package:propconnect/createaccount_screen.dart';
import 'package:propconnect/signin_page1.dart';
import 'package:propconnect/splash_screen.dart';
//import 'package:propconnect/splash_screen.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) =>const  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      builder: DevicePreview.appBuilder,
      home: CreateAccountScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
