// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  

  Future<String> uploadImageTOStorage(String athletePic, Uint8List file,) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        Reference ref = _storage.ref().child('${user.uid}/athletePic');
        UploadTask uploadTask = ref.putData(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadurl = await snapshot.ref.getDownloadURL();
        print('Upload successful. Download URL: $downloadurl');
        return downloadurl;
      } else {
        throw Exception('User is not signed in');
      }
    } catch (error, stackTrace) {
      print('Error uploading image to Firebase Storage: $error');
      // Print the stack trace for debugging purposes
      print(stackTrace);
      return 'Error uploading image to Firebase Storage: $error';
    }
  }

Future<String?> registerUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user?.uid;  // Return the UID

  } catch (e) {
    print('Registration failed: ${e.toString()}');
    // Handle registration failure
    return null;
  }
}

Future<String?> checkVerificationCodeAndUpdate(
  String code,
  String ? uid,  // The Firebase-generated UID
  String email,
  String firstName,
  String lastName,
  String squat,
  String bench,
  String deadlift,
  Uint8List file,
) async {
   final user = _auth.currentUser;
    String imageUrl = await uploadImageTOStorage('${user?.uid}/athletePic', file);
  final snapshot = await FirebaseFirestore.instance
      .collection('Athletes')
      .where('randomCode', isEqualTo: code)
      .get();

  if (snapshot.docs.isNotEmpty) {
    // Get the old document's data
    Map<String, dynamic> oldData = snapshot.docs.first.data();

    // Save the fields you want to keep from the old document
    Map<String, dynamic> dataToKeep = {
      'coachId': oldData['coachId'],
      'randomCode': oldData['randomCode'],
      // include new fields
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'squat': squat,
      'bench': bench,
      'deadlift': deadlift,
      'imageLink': imageUrl,
      
    };

    // Create a new document with the new ID (Firebase-generated UID)
    // using both the data to keep and the new data
    await FirebaseFirestore.instance.collection('Athletes')
        .doc(uid)
        .set(dataToKeep);

    // Delete the old document
    await FirebaseFirestore.instance.collection('Athletes')
        .doc(snapshot.docs.first.id)
        .delete();
         return snapshot.docs.first.id.toString();
  } else {
    // If there is no matching document, do nothing
    print('No document with that code found');
  }
}

// Future<void> saveUserInfo(
  // String firstName,
  // String lastName,
  // String squat,
  // String bench,
  // String deadlift,
//   Uint8List file,
//   String verificationCode,
// ) async {
//   try {
    // final user = _auth.currentUser;
    // String imageUrl = await uploadImageTOStorage('${user?.uid}/athletePic', file);
    // if (user != null) {
//       // Check if the document has the verification code and update it with the user's information
//       DocumentSnapshot? snapshot = await checkVerificationCodeAndUpdate(verificationCode);
//       if (snapshot != null &&
//           snapshot.data() != null &&
//           (snapshot.data() as Map<String, dynamic>)['randomCode'] == verificationCode) {
//         // update the document with the user's information
//         // create a subcollection named "uid" and save the user's UID in it
        // await _db.collection('Athletes').doc(snapshot.id).collection('uid').doc(user.uid).set({
        //    'firstName': firstName,
        //   'lastName': lastName,
        //   'squat': squat,
        //   'bench': bench,
        //   'deadlift': deadlift,
        //   'imageLink': imageUrl,
        // });
//       } else {
//         throw Exception('Verification code is not valid');
//       }
//       FirebaseAuth.instance.idTokenChanges().listen((User? user) {
//         if (user != null) {
//           user.getIdToken().then((String idToken) {
//             // Use the ID token to authenticate the user with other Firebase services and APIs
//             print('User ID token: $idToken');
//           });
//         } else {
//           print('User is signed out');
//         }
//       });
//     } else {
//       throw Exception('User is not signed in');
//     }
//   } catch (error, stackTrace) {
//     print('Error saving user info: $error');
//     print(stackTrace);
//     // Handle error saving user info
//   }
// }

  Future<bool> isUserSignedUp(String email) async {
    try {
      List<String> signInMethods =
          await _auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      print('Error checking if user is signed up: ${e.toString()}');
      return false;
    }
  }


  Future<void> updateUserProfile(String firstName, String lastName,
      String squat, String bench, String deadlift, File? image) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final data = {
        'firstName': firstName,
        'lastName': lastName,
        'squat': squat,
        'bench': bench,
        'deadlift': deadlift,
      };
      await FirebaseFirestore.instance
          .collection('Athletes')
          .doc(user.uid)
          .update(data);
      if (image != null) {
        final ref =
            FirebaseStorage.instance.ref().child('${user.uid}/ChangePic');
        final task = ref.putFile(image);
        final snapshot = await task.whenComplete(() {});
        final url = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('Athletes')
            .doc(user.uid)
            .update({'imageLink': url});
      }
    }
  }
}
