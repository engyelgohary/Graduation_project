import 'package:flutter/material.dart';
class Forget extends StatelessWidget {
  const Forget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Email Sent',style: TextStyle(fontSize: 20,color: Colors.white),),
     
        Container(
          padding: EdgeInsets.all(20,),
          child: Text('We sent a token to your e-mail that will expire after 30 minutes',style: TextStyle(fontSize: 15,color: Colors.grey),)),
          
           Container(
          padding: EdgeInsets.all(20,),
          child: Text('Click on the link that we sent inside the e-mail to change your password for a new one and then try to login with your new password!',style: TextStyle(fontSize: 15,color: Colors.grey),)),
            SizedBox(
                height: 30,
               ),
           Container(
             padding: EdgeInsets.all(20,),
             child: ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/enterpassword');},
                 style: ButtonStyle (
                  minimumSize: MaterialStateProperty.all(Size(380, 40)),
                  backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
                 ),
                 child:Text("Back to login", style: TextStyle(fontSize: 18),),
                 ),
           ),
              

      ],

      )),
    );
  }
}