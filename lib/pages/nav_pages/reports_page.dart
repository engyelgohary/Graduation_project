// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text('Reports'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
              icon: Icon(Icons.message))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(425, 60),
                    primary: Color.fromARGB(255, 48, 50, 51),
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Navigator.pushNamed(context, '/bodyweight');
                },
                icon: Icon(
                  Icons.monitor_weight_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                label: Text(
                  'BodyWeight',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(425, 60),
                    primary: Color.fromARGB(255, 48, 50, 51),
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Navigator.pushNamed(context, '/stepcount');
                },
                icon: Icon(
                  Icons.directions_walk_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                label: Text(
                  'Step Count',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(425, 60),
                    primary: Color.fromARGB(255, 48, 50, 51),
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Navigator.pushNamed(context, '/Measureshistory');
                },
                icon: Icon(
                  Icons.boy_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                label: Text(
                  'Body Measurements',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(425, 60),
                    primary: Color.fromARGB(255, 48, 50, 51),
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerLeft),
                onPressed: () {
                  Navigator.pushNamed(context, '/nutrition');
                },
                icon: Icon(
                  Icons.restaurant_menu_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                label: Text(
                  'Nutrition',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
