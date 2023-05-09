// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Code extends StatelessWidget {
  const Code ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff424949),
     appBar: AppBar(
      backgroundColor: Color(0xff424949),
     ),
     body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Enter Verification code',style: TextStyle(
                fontSize: 25,color: Colors.white,
              ),
              //textAlign: TextAlign.center,
              ),
            ),
                SizedBox(
                  height: 30,
                ),
                Text('Enter the code sent to your email',style: TextStyle(
                    fontSize: 20,color: Colors.grey,
                  ),),
                  SizedBox(
                    height: 140,
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
                 Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: TextField(
                        onChanged: (value) {
                          if (value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                           focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                    ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],

                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: TextField(
                        onChanged: (value) {
                          if (value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                           focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                    ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],

                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: TextField(
                        onChanged: (value) {
                          if (value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                           focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                    ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],

                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: TextField(
                        onChanged: (value) {
                          if (value.length==1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                           focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                    ),
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    )
                  ],
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
                  SizedBox(
                    height: 25,

                  ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Did not receive a code?',style: TextStyle(
                color:Colors.white
              )),
              Text('   Resend',style: TextStyle(
                color:Color(0xff45B39D),
              ) ,)
            ],
          ),
          ],
        ),
                ),
        );
  }
}
