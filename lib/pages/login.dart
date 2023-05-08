import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Color(0xff424949),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           Text(' Login',style: TextStyle(
            fontSize: 25,color: Colors.white,
           ),),
           SizedBox(
            height: 20,
           ),
           Text('Enter your email',style: TextStyle(
            fontSize: 15,color: Colors.grey,
           ),),
           SizedBox(
            height: 20,
           ),
           Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
             color:Color(0xffBDC3C7),
           ),
           child: Column(
             children: [
               TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  prefixIcon: Icon(Icons.email,color:Color(0xff45B39D),size: 20,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                )
                ),
               ),
               SizedBox(
                height: 15,
               ),
               ElevatedButton(onPressed: (){},
               style: ButtonStyle (
                minimumSize: MaterialStateProperty.all(Size(380, 40)),
                backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
               ),
               child:Text("Next", style: TextStyle(fontSize: 15),),
               ),

               SizedBox(
                height: 15,
               )
             ],
           ),
         ),
          ]),
        ),
        
        ),
      
    );
  }
}