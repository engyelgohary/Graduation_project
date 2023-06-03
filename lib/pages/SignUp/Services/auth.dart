
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;

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
) async {
try {
final user = _auth.currentUser;

  if (user != null) {
    await _db.collection('Athlete_').doc(user.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'squat': squat,
      'bench': bench,
      'deadlift': deadlift,
      
    });
  }
} catch (e) {
  print('Error saving user info: ${e.toString()}');
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
}