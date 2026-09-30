import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'assignment_list_screen.dart';
import 'course_list_screen.dart';
import 'profile_screen.dart'; // Import the ProfileScreen

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Three screens: Home, Assignments, and Courses
  final List<Widget> _screens = [
    const HomeScreen(),
    const AssignmentListScreen(),
    const CourseListScreen(),
    ProfileScreen(), // Add the ProfileScreen here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ), // BottomNavigationBarItem

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Assignments',
          ), // BottomNavigationBarItem

          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ), // BottomNavigationBarItem
        ],
      ), // BottomNavigationBar
    ); // Scaffold
  }
}