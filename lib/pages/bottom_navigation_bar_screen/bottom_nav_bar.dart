import 'package:crop_monitoring_app_orginal/pages/community_screen/community_screen.dart';
import 'package:crop_monitoring_app_orginal/pages/fields_screen/fields_screen.dart';
import 'package:crop_monitoring_app_orginal/pages/learning_screen/learning_screen.dart';
import 'package:crop_monitoring_app_orginal/pages/map_screen/map_screen.dart';
import 'package:crop_monitoring_app_orginal/pages/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MapScreen(),
    LearningScreen(),
    FieldsScreen(),
    CommunityScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Fields'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
