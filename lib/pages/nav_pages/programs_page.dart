import 'package:flutter/material.dart';

class Programs_page extends StatelessWidget {
  const Programs_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar( 
              toolbarHeight: 80,
               backgroundColor:Colors.black,
            automaticallyImplyLeading: false,
            title: Text('My Programs'),
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