// ignore_for_file: unused_local_variable



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


import '../login/login.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
   final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final squatController = TextEditingController();
  final benchController = TextEditingController();
  final deadliftController = TextEditingController();


  late String firstName = '';
  late String lastName = '';
  late String squat = '';
  late String bench = '';
  late String deadlift = '';
  late String imageUrl = '';

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    final userRef = FirebaseFirestore.instance.collection('Athlete_').doc(user!.uid);

    userRef.snapshots().listen((snapshot) {
      final userData = snapshot.data()! as Map<String, dynamic>;
      setState(() {
        firstName = userData['firstName'];
        lastName = userData['lastName'];
        squat = userData['squat'];
        bench = userData['bench'];
        deadlift = userData['deadlift'];
        imageUrl = userData['imageLink'];
      });
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    squatController.dispose();
    benchController.dispose();
    deadliftController.dispose();
    super.dispose();
  }

  void _showEditDialog() {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    squatController.text = squat;
    benchController.text = bench;
    deadliftController.text = deadlift;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              TextFormField(
                controller: squatController,
                decoration: InputDecoration(
                  labelText: 'Squat',
                ),
              ),
              TextFormField(
                controller: benchController,
                decoration: InputDecoration(
                  labelText: 'Bench',
                ),
              ),
              TextFormField(
                controller: deadliftController,
                decoration: InputDecoration(
                  labelText: 'Deadlift',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newFirstName = firstNameController.text;
                final newLastName = lastNameController.text;
                final newSquat = squatController.text;
                final newBench = benchController.text;
                final newDeadlift = deadliftController.text;

                final userRef = FirebaseFirestore.instance.collection('Athlete_').doc(FirebaseAuth.instance.currentUser!.uid);
                userRef.update({
                  'firstName': newFirstName,
                  'lastName': newLastName,
                  'squat': newSquat,
                  'bench': newBench,
                  'deadlift': newDeadlift,
                });
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
                Navigator.pop(context);
                 
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  
 
  @override
 Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userRef = FirebaseFirestore.instance.collection('Athlete_').doc(user!.uid);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
                appBar: AppBar( 
                toolbarHeight: 60,
                 backgroundColor:Colors.black,
              automaticallyImplyLeading: false,
              title: Text('Profile',style: TextStyle(fontSize:20),),
            titleSpacing: 15,
            actions: [
              ElevatedButton.icon( onPressed:(){
                _showEditDialog();
              },
              style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 80),
                    primary:Colors.black,
                     padding: EdgeInsets.all(10),
                     alignment: Alignment.centerLeft
                  ),
               icon: Icon(Icons.edit,color:Color(0xff45B39D)),
              label: Text('Edit',style: TextStyle(color: Color(0xff45B39D),fontSize: 15,),))
            ],
                  ),
      body:Column(
              children: [
                SizedBox(
height: 20,
                ),
                Center(
                  child: Stack(
                    children:<Widget>[
                     CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 80,
                    ),
                     Positioned(bottom:5,right: 5,
                            child: IconButton(onPressed:(){},
                             icon: Icon(Icons.edit,color: Color(0xff45B39D),size: 25,)))
                    ]
                  ),
                ),
                SizedBox(height: 16),
                Text('$firstName $lastName', style: TextStyle(fontSize: 30,color: Colors.white,)),
                SizedBox(height: 8),
                 ElevatedButton(onPressed: ()async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  },
            child: Text('Logout',style:TextStyle(fontSize: 20,),),
             
                 style: ButtonStyle (
                   minimumSize: MaterialStateProperty.all(Size(380, 40)),
                   backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 116, 11, 1)),
                   padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
                 ),
                
               ),
              ],
    ), 
    );
  }
}
