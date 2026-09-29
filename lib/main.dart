import 'package:flutter/material.dart';
import 'dart:async';
import 'views/main_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const HomeworkTrackerApp());
}

class HomeworkTrackerApp extends StatelessWidget {
  const HomeworkTrackerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework Tracker',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SplashScreen(),
    );
  }
}

class  SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MainNavigationScreen()
          ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Homework Tracker',
          style: TextStyle(
            fontSize: 28,
            color: const Color.fromARGB(255, 255, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


