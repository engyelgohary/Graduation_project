import 'package:flutter/material.dart';
import 'package:flutterdatabasesalah/pages/login/auth.dart';
import 'package:flutterdatabasesalah/pages/login/login.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/main_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context,snapshot){
        if (snapshot.hasData) {
          return MainPage();
        }else {
          return Login();
        }
      }
      );
  }
}