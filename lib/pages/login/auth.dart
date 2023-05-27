import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabasesalah/pages/login/login.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/calender_page.dart';

class Auth  extends StatelessWidget {
  const Auth ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<User?>(
    stream : FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
          if (snapshot.hasData) {
           return Calender_page();
          }else {
            return Login();
          }
        },
        ) ,
    );
  }
}