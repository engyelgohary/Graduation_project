// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
   var _isObscured;
   
  @override
   void initState() {
    super.initState();
    _isObscured = true;
    
  }
 
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
                  Form(
                    child: TextField(
                     obscureText: _isObscured,
                      textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                                   suffixIcon: IconButton(
                          icon: _isObscured ? const Icon(Icons.visibility,color:Color(0xff45B39D)) : const Icon(Icons.visibility_off,color:Color(0xff45B39D)),
                          onPressed: (){
                            setState(() {
                              _isObscured =!_isObscured;
                            });
                          }, 
                         ),
                    prefixIcon: Icon(Icons.lock,color:Color(0xff45B39D),size: 20,),
                    
                                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                                  )
                                  ),
                                 ),
                  ),
               Form(
                 child: TextField(
                  
                 obscureText: _isObscured,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Password confirmation",
                     suffixIcon: IconButton(
                        icon: _isObscured ? const Icon(Icons.visibility,color:Color(0xff45B39D)) : const Icon(Icons.visibility_off,color:Color(0xff45B39D)),
                        onPressed: (){
                          setState(() {
                            _isObscured =!_isObscured;
                          });
                        }, 
                       ),
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    prefixIcon: Icon(Icons.lock,color:Color(0xff45B39D),size: 20,),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                  )
                  ),
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
