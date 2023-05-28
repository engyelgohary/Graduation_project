// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabasesalah/pages/nav_pages/main_page.dart';




class Login extends StatefulWidget {
   const Login ({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in with email and password: $e');

      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          content: Text('Failed to sign in. Please check your credentials.'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
               Image(image: AssetImage('images/logo.png'),height: 80,),
               SizedBox(
                height: 40,
              ),
           Center(
             child: Text(' SIGN IN',style: TextStyle(
              fontSize: 25,color: Colors.white,
             ),),
           ),
           SizedBox(
            height: 40,
           ),
         
           Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
             color:Color.fromARGB(255, 48, 50, 51),
           ),
           child: Column(
             children: [
               TextFormField( 
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },  
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                 decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                  prefixIcon: Icon(Icons.email,color:Color(0xff45B39D),size: 20,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                )
                ),
               ),
               SizedBox(
                height: 5,
               ),
                 TextFormField(
                   validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                       keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                    prefixIcon: Icon(Icons.lock,color:Color(0xff45B39D),size: 20,),
                    focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 34)),
                                 )
                                 ),
                              
                                ),
                               
                               
               SizedBox(
                height: 20,

               ),


               ElevatedButton(onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Login',style: TextStyle(fontSize: 18),),
                 style: ButtonStyle (
                   minimumSize: MaterialStateProperty.all(Size(380, 40)),
                   backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
                   padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
                 ),
                
               ),

      
               SizedBox(
                height: 15,
               ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgetpass');
                },
                child: Text('forget Password', style: TextStyle(color: Colors.grey),)),
                  SizedBox(
                height: 15,
               ),
             ],
           ),
           ),
           SizedBox(
                height: 15,
               ),
           Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Not yet a member?',style: TextStyle(
                  color:Colors.white
                )),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('   Sign Up',style: TextStyle(
                    color:Color(0xff45B39D),
                  ) ,),
                )
              ], 
            ),
      
          ]),
          
          ),
      ), 
    );
  }

 }
 class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream <User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
      required String email,
      required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
    email: email,
     password: password,
    );
  }
  Future<void> signOut() async {
  await _firebaseAuth.signOut();
  }

}