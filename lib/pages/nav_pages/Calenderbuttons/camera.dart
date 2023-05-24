import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
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
      final photo = await ImagePicker().pickImage(source:imageType);
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
       backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor:Colors.black,
        flexibleSpace: SafeArea(
          child: Container(
           padding: EdgeInsets.only(top: 15),
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image(image: AssetImage('images/logo.png'),height: 40,),
            ],
           ),
        )
        ),
          title: Text('Progress Photos',style: TextStyle(fontSize:14),maxLines:2,),
          titleSpacing: -13,
          actions: [
            ElevatedButton.icon( onPressed:(){
               Navigator.pushNamed(context, '/progressPhoto');
            },
            style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 60),
                  primary:Colors.black,
                   padding: EdgeInsets.all(15),
                   alignment: Alignment.centerLeft
                ),
             icon: Icon(Icons.history_sharp,color:Color(0xff45B39D)),
            label: Text('Photo History',style: TextStyle(color: Color(0xff45B39D)),))
          ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(  
           children: [
              Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(90, 30,90, 0),
              child: 
              Text('Add three daily photos to track ',style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                ),
              )
              ),
               Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(100, 0,100, 0),
              child: 
              Text(' your physique progress',style: TextStyle(
                color:Colors.grey,
                fontSize: 15,
                ),
              )
              ),
              SizedBox(
                height: 25,
              ),
                
                 
                  
                    InkWell( 
                    onTap: imagePickerOption,
                      child: ClipRect(child: Image.asset('images/front.jpeg',width: 250,)),  
                    
                 ),
                
                 SizedBox(
                height: 25,
              ),
                 InkWell( 
                  onTap: imagePickerOption,
                  child: Image.asset('images/back.jpeg',width: 250,),  
                ),
                 SizedBox(
                height: 25,
              ),
                 InkWell( 
                   onTap: imagePickerOption,
                  child: Image.asset('images/side.jpeg',width: 250,),  
                ),
                   SizedBox(
                height: 25,
              ),

      
        ])),
      ),
    );
  }
}