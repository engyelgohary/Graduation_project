import 'package:flutter/material.dart';

class Calender_page extends StatefulWidget {
  const Calender_page({super.key});

  @override
  State<Calender_page> createState() => _Calender_pageState();
}

class _Calender_pageState extends State<Calender_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar( 
              toolbarHeight: 80,
               backgroundColor:Colors.black,
            automaticallyImplyLeading: false,
            title: Text('Calender'),
            actions: [
              IconButton(onPressed: (){}, 
              icon: Icon(Icons.notifications)
              ),
              IconButton(onPressed: (){}, 
              icon:Icon(Icons.message) )
            ],
        ),
       
    );
  }
}