// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../login/login.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  File?pickedImage;
void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Color.fromARGB(255, 48, 50, 51),
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10,),
                    child: const Text(
                      "Select Image From",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 40,),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
                          ),
                          onPressed: () {
                          pickImage(ImageSource.camera);
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text("CAMERA"),
                          
                        ),
                      ),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
                          ),
                    onPressed: () {
                    pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
               backgroundColor: Color.fromARGB(255, 16, 16, 16),
                appBar: AppBar( 
                toolbarHeight: 60,
                 backgroundColor:Colors.black,
              automaticallyImplyLeading: false,
              title: Text('Profile',style: TextStyle(fontSize:20),),
            titleSpacing: 15,
            actions: [
              ElevatedButton.icon( onPressed:(){
                 Navigator.pushNamed(context, '/progressPhoto');
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
                  body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                          child: Stack(
                            children:<Widget> [
                           ClipOval(
                             child:pickedImage !=null ? Image.file(pickedImage !,width: 100,height: 100,fit:BoxFit.cover,):
                              CircleAvatar(
                              backgroundColor: Colors.grey,
                               radius: 50.0,
                               backgroundImage: AssetImage('images/Profile.png',)
                             ),
                           ),
                           Positioned(bottom:1,right: -2,
                            child: IconButton(onPressed:imagePickerOption,
                             icon: Icon(Icons.edit,color: Colors.black,size: 25,)))
                           ],
          
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
            ]
            ),
          );
          }
  }
