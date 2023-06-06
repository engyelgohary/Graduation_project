
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AuthService {
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;



Future<String> uploadImageTOStorage(String athletePic,Uint8List file) async{ 
  try {
  final user = _auth.currentUser;
  if (user != null) {
  Reference ref = _storage.ref().child('${user.uid}/$athletePic').child('pic');
  UploadTask uploadTask = ref.putData(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadurl = await snapshot.ref.getDownloadURL();
 print('Upload successful. Download URL: $downloadurl');
  return downloadurl;
  }else {
     throw Exception('User is not signed in');
  }
  }
  catch (error, stackTrace) {
    print('Error uploading image to Firebase Storage: $error');
    // Print the stack trace for debugging purposes
    print(stackTrace);
    return 'Error uploading image to Firebase Storage: $error';
  }
}
Future<void> registerUser(String email, String password) async {
try {
await _auth.createUserWithEmailAndPassword(
email: email,
password: password,
);
} catch (e) {
print('Registration failed: ${e.toString()}');
// Handle registration failure
}
}

Future<void> saveUserInfo(
String firstName,
String lastName,
String squat,
String bench,
String deadlift,
Uint8List file,
) async {
try {
final user = _auth.currentUser;
String imageUrl = await uploadImageTOStorage('profileImage', file);
  if (user != null) {
    await _db.collection('Athlete_').doc(user.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'squat': squat,
      'bench': bench,
      'deadlift': deadlift,
      'imageLink':imageUrl,
      
    });
       FirebaseAuth.instance.idTokenChanges().listen((User? user) {
          if (user != null) {
            user.getIdToken().then((String idToken) {
              // Use the ID token to authenticate the user with other Firebase services and APIs
              print('User ID token: $idToken');
            });
          } else {
            print('User is signed out');
          }
        });
    } else{
    throw Exception('User is not signed in');
    }
  
} catch (error, stackTrace) {
 print('Error saving user info: $error');
       print(stackTrace);
  // Handle error saving user info
}
}

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
  Future<void> signOut() async {
    await _auth.signOut();
  }
  Future<void> updateUserProfile(String firstName, String lastName, String squat, String bench, String deadlift, Uint8List file) async {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      String imageUrl = await uploadImageTOStorage('profileImage', file);
      await _db.collection('Athlete_').doc(user.uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'squat': squat,
        'bench': bench,
        'deadlift': deadlift,
        'imageLink': imageUrl,
      });
    } else {
      throw Exception('User is not signed in');
    }
  } catch (error, stackTrace) {
    print('Error updating user info: $error');
    print(stackTrace);
    // Handle error updating user info
  }
}

}