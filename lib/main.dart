import 'package:flutter/material.dart';
import 'package:untitled1/pages/Login.dart';
import 'package:untitled1/pages/VerificationCode.dart';
import 'package:untitled1/pages/enterpassword.dart';
import 'package:untitled1/pages/forgetpass.dart';
import 'package:untitled1/pages/profiledetials.dart';
import 'package:untitled1/pages/setpassword.dart';
import 'package:untitled1/pages/setup.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
  initialRoute: '/Login',
  routes: {
    '/Login': (context) => const Login(),
    '/verification code': (context) => const Code(),
    '/setpassword': (context) => const Password(),
    '/Setup': (context) => const Setup(),
    '/profile details': (context) => const Profile(),
    '/enterpassword': (context) => const SetPass(),
    '/forgetpass': (context) => const Forget(),

  });
  }
}