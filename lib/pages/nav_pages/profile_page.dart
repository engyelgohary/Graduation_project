// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabasesalah/pages/SignUp/Services/auth.dart';
import 'package:image_picker/image_picker.dart';
import '../login/login.dart';
import 'package:path_provider/path_provider.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  final AuthService _authService = AuthService();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _squatController = TextEditingController();
  final TextEditingController _benchController = TextEditingController();
  final TextEditingController _deadliftController = TextEditingController();

  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('Athletes')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        _firstNameController.text = data['firstName'];
        _lastNameController.text = data['lastName'];
        _squatController.text = data['squat'];
        _benchController.text = data['bench'];
        _deadliftController.text = data['deadlift'];
        setState(() {
          _imageUrl = data['imageLink'];
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final squat = _squatController.text;
    final bench = _benchController.text;
    final deadlift = _deadliftController.text;

    File? imageFile;
    if (_image != null) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String filePath = '$tempPath/image.png';
      imageFile = File(filePath);
      await imageFile.writeAsBytes(_image!);
    }
    try {
      await _authService.updateUserProfile(
        firstName,
        lastName,
        squat,
        bench,
        deadlift,
        imageFile,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No image selected');
  }

  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 20),
        ),
        titleSpacing: 15,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            icon: Icon(Icons.logout_outlined, color: Color(0xff45B39D)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 48, 50, 51),
            ),
            child: Form(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: <Widget>[
                        _image != null
                            ? CircleAvatar(
                                radius: 50.0,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 50.0,
                                backgroundImage: _imageUrl != null
                                    ? NetworkImage(_imageUrl!)
                                    : null,
                              ),
                        Positioned(
                            bottom: 1,
                            right: -2,
                            child: IconButton(
                                onPressed: selectImage,
                                icon: Icon(
                                  Icons.edit,
                                  color: Color(0xff45B39D),
                                  size: 25,
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _firstNameController.text,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        _lastNameController.text,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: TextFormField(
                            controller: _firstNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: "FirstName",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 53, 53, 53))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Color(0xff45B39D)))),
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: TextFormField(
                            controller: _lastNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: "LastName",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 53, 53, 53))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Color(0xff45B39D)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _squatController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Squat",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 53, 53))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Color(0xff45B39D)))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _benchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Bench",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 53, 53))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Color(0xff45B39D)))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _deadliftController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Deadlift",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 53, 53, 53))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Color(0xff45B39D)))),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _saveUserData,
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(380, 40)),
              backgroundColor: MaterialStateProperty.all(Color(0xff45B39D)),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ]),
      ),
    );
  }
}
