
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/pages/SignUp/VerificationCode.dart';
import 'package:untitled1/pages/login/forgetpass.dart';
import 'package:untitled1/pages/login/login.dart';
import 'package:untitled1/pages/nav_pages/main_page.dart';
import 'package:untitled1/pages/SignUp/profiledetials.dart';
import 'package:untitled1/pages/SignUp/setpassword.dart';
import 'package:untitled1/pages/SignUp/setup.dart';
import 'package:untitled1/pages/SignUp/signup.dart';
import 'package:untitled1/pages/nav_pages/reportsbuttons/RPE.dart';
import 'package:untitled1/pages/nav_pages/reportsbuttons/bodymeasurements.dart';
import 'package:untitled1/pages/nav_pages/reportsbuttons/bodyweight.dart';
import 'package:untitled1/pages/nav_pages/reportsbuttons/progressphoto.dart';
import 'package:untitled1/pages/nav_pages/reportsbuttons/stepcount.dart';






void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 

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
        'progressPhoto': (context) => const ProgressPhoto(),  

          
  },
      

        
  );
  }
}