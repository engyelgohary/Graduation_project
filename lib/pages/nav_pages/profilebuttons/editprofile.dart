import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../SignUp/Services/auth.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile>{
  final _formKey = GlobalKey<FormState>();
String _firstName = '';
String _lastName = '';
String _squat = '';
String _bench = '';
String _deadlift = '';
Uint8List _imageFile = Uint8List(0);

Future<void> _getUserProfileInfo() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final snapshot = await FirebaseFirestore.instance.collection('Athlete_').doc(user.uid).get();
    if (snapshot.exists) {
      final data = snapshot.data()!;
      setState(() {
        _firstName = data['firstName'];
        _lastName = data['lastName'];
        _squat = data['squat'];
        _bench = data['bench'];
        _deadlift = data['deadlift'];
        // Set the initial value of the image file to the current user's profile picture
        // You will need to implement a way to download the image from the URL and convert it to a Uint8List
      });
    }
  }
}

void _onSaveButtonPressed() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    await AuthService().updateUserProfile(_firstName, _lastName, _squat, _bench, _deadlift, _imageFile);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
  }
}

// Call _getUserProfileInfo() when the widget is created to fetch the current user data
@override
void initState() {
  super.initState();
  _getUserProfileInfo();
}
  
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
   final userRef = FirebaseFirestore.instance.collection('Athlete_').doc(user!.uid);
     return Scaffold(
    appBar: AppBar(
      title: Text('Edit Profile'),
    ),
    body: StreamBuilder<DocumentSnapshot>(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _firstName,
                decoration: InputDecoration(labelText: 'FirstName:'),
                onSaved: (value) => _firstName = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _lastName,
                decoration: InputDecoration(labelText: 'last Name'),
                onSaved: (value) => _lastName = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _squat,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Squat'),
                onSaved: (value) => _squat = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your squat max';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _bench,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Bench'),
                onSaved: (value) => _bench = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your bench max';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _deadlift,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Deadlift'),
                onSaved: (value) => _deadlift = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your deadlift max';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
             
             // Add image picker widget here to allow user to select a new profile picture
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _onSaveButtonPressed,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
        }
    ),
  );
  }
}