import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:device_preview/device_preview.dart';
import 'package:http/http.dart' as http;
import 'package:propconnect/providers/favorite_provider.dart';
import 'package:propconnect/providers/user_provider.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:propconnect/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => 
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
          child: const MyApp(),
        ),
    ),
  );
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
      final response = await http.get(Uri.parse('https://8fa4-2403-a080-1004-a111-25e7-6fd0-448b-ba9b.ngrok-free.app/'),headers: {'ngrok-skip-browser-warning': 'true'},);


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
    return MultiProvider(
       providers: [
        // Register your providers here
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],

    child: MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while checking connection
          : isBackendConnected
              ? const SplashScreen() // Proceed if backend is connected
              : const ErrorScreen(), // Show an error screen if connection fails

    ));
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
