



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabasesalah/pages/SignUp/VerificationCode.dart';
import 'package:flutterdatabasesalah/pages/SignUp/profiledetials.dart';
import 'package:flutterdatabasesalah/pages/SignUp/setpassword.dart';
import 'package:flutterdatabasesalah/pages/SignUp/setup.dart';
import 'package:flutterdatabasesalah/pages/SignUp/signup.dart';
import 'package:flutterdatabasesalah/pages/login/forgetpass.dart';
import 'package:flutterdatabasesalah/pages/login/login.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/Calenderbuttons/camera.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/Calenderbuttons/enternutrition.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/Calenderbuttons/enterweight.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/Calenderbuttons/excrsise_page.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/main_page.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/reportsbuttons/RPE.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/reportsbuttons/bodymeasurements.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/reportsbuttons/bodyweight.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/reportsbuttons/nutrition.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/reportsbuttons/progressphoto.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/reportsbuttons/stepcount.dart';
import 'package:flutterdatabasesalah/widget_tree.dart';
import 'package:get/get.dart';





Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({super.key}); 
  


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
  initialRoute: '/Login',
  routes: {
    '/Login': (context) => const Login(),
    '/verification code': (context) => const Code(),
    '/setpassword': (context) => const Password(),
    '/Setup': (context) => const Setup(),
    '/profile details': (context) => const Profile(),
    '/forgetpass': (context) => const Forget(),
    '/signup': (context) => const Signup(),
    '/main_page': (context) => const MainPage(), 
    '/PRE': (context) => const PRE(), 
    '/bodyweight': (context) => const BodyWeight(), 
    '/stepcount': (context) => const StepCount(), 
    '/bodymeasurements': (context) => const BodyM(),
     '/nutrition': (context) => const Nut(), 
    '/progressPhoto': (context) => const ProgressPhoto(),  
    '/Camera': (context) => const Camera(), 
    '/enter_weight': (context) => const Enter_Weight(), 
    '/enter_nutrition': (context) => const Enter_Nut(), 
    '/excrsise': (context) => const Add(),       
  }, 
      home: WidgetTree(),
  );
  
  }
}

