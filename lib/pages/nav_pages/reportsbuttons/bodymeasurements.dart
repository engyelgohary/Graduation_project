import 'package:flutter/material.dart';

class BodyM extends StatelessWidget {
  const BodyM({super.key});

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
          title: Text('Measures',style: TextStyle(fontSize:16 ,),),
          titleSpacing: -13,
      ),
      
    );
  }
}