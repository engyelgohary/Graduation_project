// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Enter_Weight extends StatefulWidget {
  const Enter_Weight({super.key});

  @override
  State<Enter_Weight> createState() => _Enter_WeightState();
}

class _Enter_WeightState extends State<Enter_Weight> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor:Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
           padding: EdgeInsets.only(top: 15),
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image(image: AssetImage('images/logo.png'),height: 40,),
            ],
           ),
        )
        ),
          title: Text('BodyWeight',style: TextStyle(fontSize:15),),
          titleSpacing: -13,
          actions: [
            ElevatedButton.icon( onPressed:(){
                 Navigator.pushNamed(context, '/bodymeasurements');
            },
            style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 20),
                  primary:Colors.black,
                   padding: EdgeInsets.all(5),
                   alignment: Alignment.centerLeft
                ),
             icon: Icon(Icons.boy_rounded,color:Color(0xff45B39D)),
            label: Text('body Measurse',style: TextStyle(color: Colors.white),))
          ],
      ),
    );
  }
}