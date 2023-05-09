import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

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
                  color:Colors.grey,
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
              ],
            ),
        ),
      ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                 Image(image: AssetImage('images/logo.png'),height: 50,),
               SizedBox(height: 10,),
                Text('profile details',style: TextStyle(
                  color: Colors.white,fontSize: 25,
                ),maxLines: 5,),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,),
                  child: Text('Enter your 1RMs to help us calculate the weights for you to use in your programs. These can always be changed later, so include your best estimate of a weight you can lift for 1 repetition on any day.',style: TextStyle(
                    color: Colors.grey,fontSize: 15,
                  ),),
                ),
                Container(
                  child: Column(
                    
                  ),
                )
                  
              ],
            ),
          ),
        )),
    );
  }
}