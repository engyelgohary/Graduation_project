import 'package:flutter/material.dart';

class Enter_Nut extends StatelessWidget {
  const Enter_Nut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor:Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
           padding: EdgeInsets.only(top: 15),
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image(image: AssetImage('images/logo.png'),height: 40,),
            ],
           ),
        )
        ),
          title: Text('Nutrition',style: TextStyle(fontSize:14),maxLines:2,),
          titleSpacing: -13,
          actions: [
            ElevatedButton.icon( onPressed:(){
               Navigator.pushNamed(context, '/nutrition');
            },
            style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 60),
                  primary:Colors.black,
                   padding: EdgeInsets.all(15),
                   alignment: Alignment.centerLeft
                ),
             icon: Icon(Icons.history_sharp,color:Color(0xff45B39D)),
            label: Text('Nutrition Log',style: TextStyle(color: Color(0xff45B39D)),))
          ],
      ),
    );
  }
}