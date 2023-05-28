// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'programs_page.dart';
import 'calender_page.dart';
import 'reports_page.dart';
import 'profile_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  User? _user;
  List pages = [
    Calender_page(),
    Programs_page(),
    Reports(),
    Profile_page(),
  ];
  int currentIndex=0;
  void onTap (int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();

    // Check if the user is already signed in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xff45B39D),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,

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
            icon:Icon(IconlyLight.user2)
            ),
      ]
      ),
    );
  }
}