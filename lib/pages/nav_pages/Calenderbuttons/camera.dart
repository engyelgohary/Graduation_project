// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: Colors.black,
        flexibleSpace: SafeArea(
            child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/logo.png'),
                height: 40,
              ),
            ],
          ),
        )),
        title: Text(
          'Progress Photos',
          style: TextStyle(fontSize: 14),
          maxLines: 2,
        ),
        titleSpacing: -13,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/progressPhoto');
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 60),
                  primary: Colors.black,
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft),
              icon: Icon(Icons.history_sharp, color: Color(0xff45B39D)),
              label: Text(
                'Photo History',
                style: TextStyle(color: Color(0xff45B39D)),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(children: [
          Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(90, 30, 90, 0),
              child: Text(
                'Add three daily photos to track ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              )),
          Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
              child: Text(
                ' your physique progress',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              )),
          SizedBox(
            height: 25,
          ),
          InkWell(
              onTap: () {},
              child: Image.asset(
                'images/front.jpeg',
                width: 250,
              )),
          SizedBox(
            height: 25,
          ),
          InkWell(
              onTap: () {},
              child: Image.asset(
                'images/back.jpeg',
                width: 250,
              )),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              'images/side.jpeg',
              width: 250,
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ])),
      ),
    );
  }
}
