import 'package:flutter/material.dart';

class Calender_page extends StatefulWidget {
  const Calender_page({super.key});

  @override
  State<Calender_page> createState() => _Calender_pageState();
}

class _Calender_pageState extends State<Calender_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('calender page',style: TextStyle(fontSize: 50,color: Colors.white),),
      ),

    );
  }
}