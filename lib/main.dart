// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabasesalah/pages/login/login.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/main_page.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/reportsbuttons/howmeasure.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'pages/SignUp/signup.dart';
import 'pages/login/forgetpass.dart';
import 'pages/nav_pages/Calenderbuttons/camera.dart';
import 'pages/nav_pages/Calenderbuttons/enternutrition.dart';
import 'pages/nav_pages/Calenderbuttons/enterweight.dart';
import 'pages/nav_pages/chat.dart';
import 'pages/nav_pages/reportsbuttons/bodymeasurements.dart';
import 'pages/nav_pages/reportsbuttons/bodyweight.dart';
import 'pages/nav_pages/reportsbuttons/nutrition.dart';
import 'pages/nav_pages/reportsbuttons/progressphoto.dart';
import 'pages/nav_pages/reportsbuttons/stepcount.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return ChangeNotifierProvider<NutritionDataModel>(
      create: (context) => NutritionDataModel(),
      child:
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Login': (context) => const Login(),
        '/forgetpass': (context) => const Forget(),
        '/signup': (context) => const Signup(),
        '/main_page': (context) => const MainPage(),
        '/bodyweight': (context) => const BodyWeight(),
        '/stepcount': (context) => const StepCount(),
        '/bodymeasurements': (context) => const BodyM(),
        '/nutrition': (context) => const Nut(),
        '/progressPhoto': (context) => const ProgressPhoto(),
        '/Camera': (context) => const Camera(),
        '/enter_weight': (context) => const Enter_Weight(),
        '/enter_nutrition': (context) => const EnterNutrition(),
        '/chat': (context) => const chatPage(),
        '/measure': (context) => const Measure(),
      },
      home: Login(),
    )
    );
  }
}
