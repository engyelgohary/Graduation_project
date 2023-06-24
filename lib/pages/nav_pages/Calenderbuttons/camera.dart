// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();


}

class _CameraState extends State<Camera> {
 final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> _imageUrls = [];
  Future<void> saveImages(String uid) async {
  // Get the current date
  DateTime now = DateTime.now();
  String date = now.toString().substring(0, 10);

  // Check if the user has already saved images for today
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('Athletes')
      .doc(uid)
      .collection('progress photo')
      .doc(date)
      .get();
  if (snapshot.exists) {
    return;
  }

  // If the user hasn't saved images for today, save them now
  List<String> imageUrls = [];
  for (int i = 0; i < 3; i++) {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    String imageName = '${uid}_${date}_${i + 1}.jpg';
    Reference ref = FirebaseStorage.instance.ref().child(imageName);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    imageUrls.add(downloadUrl);
  }

  // Save the image URLs to the Firebase Firestore database
  FirebaseFirestore.instance
      .collection('Athletes')
      .doc(uid)
      .collection('progress photo')
      .doc(date)
      .set({
    'date': date,
    'imageUrls': imageUrls,
  });
}

  Future<void> _saveImages() async {
    // Get the current user's UID
    String uid = _auth.currentUser!.uid;

    // Call the saveImages function
    await saveImages(uid);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Images saved successfully!')),
    );
  }

  Future<void> _getImages() async {
    // Get the current user's UID
    String uid = _auth.currentUser!.uid;

    // Get the progress photos subcollection for the current user
    QuerySnapshot querySnapshot = await _firestore
        .collection('Athletes')
        .doc(uid)
        .collection('progress photo')
        .get();

    // Extract the image URLs from the query snapshot
    List<dynamic> imageUrls = [];
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      imageUrls.addAll(documentSnapshot.get('imageUrls'));
    }

    // Update the state with the image URLs
    setState(() {
      _imageUrls = imageUrls;
    });
  }

  Future<void> _showImageDialog(String imageUrl) async {
    // Show a dialog with the selected image
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.network(imageUrl),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: Colors.black,
        flexibleSpace: SafeArea(
            child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/logo.png'),
                height: 40,
              ),
            ],
          ),
        )),
        title: Text(
          'Progress Photos',
          style: TextStyle(fontSize: 14),
          maxLines: 2,
        ),
        titleSpacing: -13,
        
      ),
  body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _saveImages,
              child: Text('Save Images'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getImages,
              child: Text('View Images'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: _imageUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  String imageUrl = _imageUrls[index];
                  return GestureDetector(
                    onTap: () => _showImageDialog(imageUrl),
                    child: Image.network(imageUrl),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
