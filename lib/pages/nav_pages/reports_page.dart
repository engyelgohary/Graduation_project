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
          appBar: AppBar( 
              toolbarHeight: 80,
               backgroundColor:Colors.black,
            automaticallyImplyLeading: false,
            title: Text('Reports'),
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