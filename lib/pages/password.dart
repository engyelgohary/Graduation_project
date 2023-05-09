// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Color(0xff45B39D),
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Column(
          children: [
            Image(image: AssetImage('images/logo.png'),height: 100,),
            SizedBox(height: 30,),
            Text('Create a new password',style: TextStyle(
              color: Colors.white,fontSize: 20,
            ),),
            SizedBox(
              height: 50,
            ),
            Container(
               padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
            color:Color.fromARGB(255, 48, 50, 51),
            
           ),
              child: Column(
                children: [
                  TextField(
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                   suffixIcon: Icon(Icons.visibility,color: Color(0xff45B39D),size: 20,),
                  prefixIcon: Icon(Icons.lock,color:Color(0xff45B39D),size: 20,),
                  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                )
                ),
               ),
               TextField(
                
               
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: "Password confirmation",
                  suffixIcon: Icon(Icons.visibility,color: Color(0xff45B39D),size: 20,),
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                  prefixIcon: Icon(Icons.lock,color:Color(0xff45B39D),size: 20,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                )
                ),
               ),
               SizedBox(
                  height: 15,
                 ),
                 ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/Setup');},
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
                ]),)
          ],
        )),
      ),

    );
  }
}
