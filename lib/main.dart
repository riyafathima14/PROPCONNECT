import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:propconnect/createaccount_screen.dart';
//import 'package:propconnect/createaccount_screen.dart';
import 'package:propconnect/signin_page1.dart';
import 'package:propconnect/splash_screen.dart';
//import 'package:propconnect/splash_screen.dart';

void main() {
  checkBackendConnection(); // Call the function before running the app

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
}

void checkBackendConnection() async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/'));

    if (response.statusCode == 200) {
      print("✅ Flask Backend Connected: ${jsonDecode(response.body)}");
    } else {
      print("❌ Failed to connect to Flask: Status Code ${response.statusCode}");
    }
  } catch (e) {
    print("❌ Error connecting to Flask: $e");
  }
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
