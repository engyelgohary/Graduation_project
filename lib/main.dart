import 'package:flutter/material.dart';
import 'package:untitled1/pages/Login.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  initialRoute: '/Login',
  routes: {
    '/Login': (context) => const Login(),
  });
  }
}