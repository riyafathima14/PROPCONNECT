import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:propconnect/homepage.dart';

/*import 'package:propconnect/createaccount_screen.dart';

import 'package:propconnect/search_screen1.dart';
import 'package:propconnect/signin_page1.dart';
import 'package:propconnect/splash_screen.dart';*/


void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isBackendConnected = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkBackendConnection();
  }

  Future<void> checkBackendConnection() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.3:5000/'));

      if (response.statusCode == 200) {
        print("✅ Flask Backend Connected: ${jsonDecode(response.body)}");
        setState(() {
          isBackendConnected = true;
        });
      } else {
        print("❌ Failed to connect to Flask: Status Code ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error connecting to Flask: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while checking connection
          : isBackendConnected
              ? const HomePage() // Proceed if backend is connected
              : const ErrorScreen(), // Show an error screen if connection fails
    );
  }
}

// Screen to show when backend is not connected
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("❌ Backend Connection Failed!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Restart the app (or retry connection logic)
                main();
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
