import 'package:flutter/material.dart';
class SetPass extends StatelessWidget {
  const SetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 3, 3, 3),
     ),
     body: SingleChildScrollView(
      child: SafeArea(child:Column(
        children: [
          Image(image: AssetImage('images/logo.png'),height: 80,),
          SizedBox(
                height: 20,
              ),
          Center(
                child: Text('Password',style: TextStyle(
                  fontSize: 25,color: Colors.white,
                ),
                //textAlign: TextAlign.center,
                ),
              ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Enter your password',style: TextStyle(
                      fontSize: 20,color: Colors.grey,
                    ),),
                    SizedBox(
                      height: 90,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
            color:Color.fromARGB(255, 48, 50, 51),
           ),
           child: Column(children: [
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
                 child:Text("Login", style: TextStyle(fontSize: 20),),
                 ),
                 SizedBox(
                  height: 15,
                 ),
                  ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/forgetpass');},
                 style: ButtonStyle (
                  minimumSize: MaterialStateProperty.all(Size(380, 40)),
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 48, 50, 51),),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  //shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
                 ),
                 child: Text("Forget password", style: TextStyle(fontSize: 15,color: Colors.grey),),
                 ),

           ]),

                    )
        ],
      ) 
      ),
     ),
    );
  }
}