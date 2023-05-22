// ignore_for_file: prefer_const_constructor


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color:Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle,
                 color: Color(0xff45B39D),
                  size: 10,
                ),
                
              ],
            ),
        ),
      ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                 Image(image: AssetImage('images/logo.png'),height: 50,),
               SizedBox(height: 10,),
                Text('Profile details',style: TextStyle(
                  color: Colors.white,fontSize: 25,
                ),maxLines: 5,),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,),
                  child: Text('Enter your 1RMs to help us calculate the weights for you to use in your programs. These can always be changed later, so include your best estimate of a weight you can lift for 1 repetition on any day.',style: TextStyle(
                    color: Colors.grey,fontSize: 15,
                  ),),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                      padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                          color:Color.fromARGB(255, 48, 50, 51),
                         ),
                  child: Column(
                    
                    children: <Widget> [
                       Container
                       (alignment: Alignment.topLeft,
                        child: Text('Profile picture',style: TextStyle(fontSize:18, color: Colors.white),)),
                        SizedBox(
                          height: 10,
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
                         Positioned(bottom:-9,right: -3,
                          child: IconButton(onPressed:imagePickerOption,
                           icon: Icon(Icons.camera_alt,color: Colors.black,size: 25,)))
                         ],

                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container
                        (alignment: Alignment.topLeft,
                          child: Text('Measurements system',style: TextStyle(fontSize:18, color: Colors.white),)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [   
                          Text('Squat 1RM',style: TextStyle(fontSize:14, color: Colors.white),),
                             Text('Branch 1RM',style: TextStyle(fontSize:14, color: Colors.white),),
                            Container(
                            padding: EdgeInsets.only(right:10,),
                            child: Text('Deadlift 1RM',style: TextStyle(fontSize:14, color: Colors.white),),
                          ),
                          ],
                  ),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           SizedBox(
                            height: 60,
                            width: 100,
                            child: TextField(
                      textInputAction: TextInputAction.next,
                              
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Colors.grey),
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                           SizedBox(
                            height: 60,
                            width: 100,
                            child: TextField(
                      textInputAction: TextInputAction.next,
                              
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Colors.grey),
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          
                          SizedBox(
                            height: 60,
                            width: 100,
                            child: TextField(
                      textInputAction: TextInputAction.done,        
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:Colors.grey),
                                
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                  height: 15,
                 ),
                  Container
                        (alignment: Alignment.center,
                          child: Text('*1RM = 1 repetition maximum',style: TextStyle(fontSize:15, color: Colors.grey),)),
                      


SizedBox(
                  height: 20,
                 ),
                 ElevatedButton(onPressed: (){
                   Navigator.pushNamed(context, '/main_page');
                 },
                 style: ButtonStyle (
                  minimumSize: MaterialStateProperty.all(Size(380, 40)),
                  backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
                 ),
                 child:Text("Start Training", style: TextStyle(fontSize: 15),),
                 ),
     
                 SizedBox(
                  height: 15,
                 )
                    ],
                  ),
                ) 
              ],
            ),
          ),
        )),
    );
  }
}


