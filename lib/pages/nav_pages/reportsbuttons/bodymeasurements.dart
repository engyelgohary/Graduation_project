import 'package:flutter/material.dart';

class BodyM extends StatefulWidget {
  const BodyM({super.key});

  @override
  State<BodyM> createState() => _BodyMState();
}

class _BodyMState extends State<BodyM> {
  
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            
            children:[
               SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/measure');
                        },
                        child: Text(
                          'How to measure',
                          style: TextStyle(color:(Color(0xff45B39D)),fontSize: 18,
                        )),
                    )
            ]
          ),
        )
        ),
    );
  }
}