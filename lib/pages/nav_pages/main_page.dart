import 'package:flutter/material.dart';
import 'package:untitled1/pages/nav_pages/calender_page.dart';
import 'package:untitled1/pages/nav_pages/profile_page.dart';
import 'package:untitled1/pages/nav_pages/programs_page.dart';
import 'package:untitled1/pages/nav_pages/reports_page.dart';

class _MainPage extends StatefulWidget {
  const _MainPage({super.key});

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  List pages = [
    Calender_page(),
    Programs_page(),
    Reports_page(),
    Profile_page(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[0],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Calender',
            icon:Icon(Icons.calendar_month_outlined)
            ),
              BottomNavigationBarItem(
            label: 'Progarms',
            icon:Icon(Icons.fitness_center_sharp)
            ),
              BottomNavigationBarItem(
            label: 'Reports',
            icon:Icon(Icons.bar_chart_rounded)
            ),
              BottomNavigationBarItem(
            label: 'Profile',
            icon:Icon(Icons.person_outline)
            ),
      ]
      ),
    );
  }
}