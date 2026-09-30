import 'package:flutter/material.dart';
import 'dart:async';
import 'views/main_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'views/login_screen.dart';

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

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Homework Tracker',
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 255, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return const MainNavigationScreen();
        }

        return const LoginScreen();
      },
    );
  }
}


