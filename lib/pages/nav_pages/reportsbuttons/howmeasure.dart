import 'package:flutter/material.dart';

class Measure extends StatelessWidget {
  const Measure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color.fromARGB(255, 16, 16, 16),
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
          title: Text('How To Measures',style: TextStyle(fontSize:14 ,),),
          titleSpacing: -13,
      ),
      body: SingleChildScrollView(
          child:Column(
            children: [ 
                Image(image: AssetImage('images/Measurment.jpg'),),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(10),
                  child: Text('Best Practices' ,style: TextStyle(color: Colors.white),)),
                  Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(15),
                  child: Text('- Over your so done ryes servents need toons conststent' ,style: TextStyle(color: Colors.white),)),
                  Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(15),
                  child: Text('- Use an automatic tightening tape, if available.' ,style: TextStyle(color: Colors.white),)),
                  Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(15),
                  child: Text('- Measure the circumference of the body part' ,style: TextStyle(color: Colors.white),)),
                  Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(15),
                  child: Text('- Measuring once per week is recommended.' ,style: TextStyle(color: Colors.white),)),
                  Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(15),
                  child: Text('- Round to the nearest 0.1 cm/in' ,style: TextStyle(color: Colors.white),)),
                  Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(10),
                  child: Text('- Measuring first thing in the morning is recommended.' ,style: TextStyle(color: Colors.white),)),
            ],
          ),
      ),
    );
  }
}