import 'package:crop_monitoring_app_orginal/Views/community_screen/community_screen.dart';
import 'package:crop_monitoring_app_orginal/Views/fields_screen/fields_screen.dart';
import 'package:crop_monitoring_app_orginal/Views/learning_screen/learning_screen.dart';
import 'package:crop_monitoring_app_orginal/Views/map_screen/map_screen.dart';
import 'package:crop_monitoring_app_orginal/Views/settings_screen/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
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
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'.tr()),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Learning'.tr(),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Fields'.tr()),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'.tr(),
          ),
        ],
      ),
    );
  }
}
