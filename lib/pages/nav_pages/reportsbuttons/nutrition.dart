import 'package:flutter/material.dart';

class Nut extends StatefulWidget {
  const Nut({super.key});

  @override
  State<Nut> createState() => _NutState();
}

class _NutState extends State<Nut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
           padding: EdgeInsets.only(top: 12),
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image(image: AssetImage('images/logo.png'),height: 40,),
            ],
           ),
        )
        ),
          title: Text('Nutrition',style: TextStyle(fontSize:16 ,),),
          titleSpacing: -13,
      ),
    );
  }
}