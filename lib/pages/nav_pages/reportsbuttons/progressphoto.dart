import 'package:flutter/material.dart';

class ProgressPhoto extends StatelessWidget {
  const ProgressPhoto({super.key});

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
          title: Text('Photo History',style: TextStyle(fontSize:16 ,),),
          titleSpacing: -13,
      ),
      
    );
  }
}