// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Enter_Weight extends StatefulWidget {
  const Enter_Weight({super.key});

  @override
  State<Enter_Weight> createState() => _Enter_WeightState();
}

class _Enter_WeightState extends State<Enter_Weight> {
 
 final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 late TextEditingController _weightController;
  double? _currentWeight;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _loadCurrentWeight();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentWeight() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot weightSnap = await _firestore
          .collection('Athletes')
          .doc(user.uid)
          .collection('weight')
          .orderBy('time', descending: true)
          .limit(1)
          .get();
      if (weightSnap.docs.isNotEmpty) {
        final DocumentSnapshot weightDoc = weightSnap.docs.first;
        setState(() {
          _currentWeight = weightDoc['weight'];
        });
        _weightController.text = _currentWeight?.toString() ?? '';
      }
    }
  }

  Future<void> _handleSubmit(BuildContext context) async {
    final String weightString = _weightController.text.trim();
    if (weightString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your weight')),
      );
      return;
    }
    final double weight = double.tryParse(weightString) ?? 0.0;
    if (weight <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid weight')),
      );
      return;
    }
    final User? user = _auth.currentUser;
    if (user != null) {
      final CollectionReference weightCollection = _firestore
          .collection('Athletes')
          .doc(user.uid)
          .collection('weight');
      final DateTime now = DateTime.now();
      final QuerySnapshot weightSnap = await weightCollection
          .where('time', isGreaterThan: Timestamp.fromDate(now.subtract(const Duration(days: 1))))
          .get();
      final List<QueryDocumentSnapshot> weightDocs = weightSnap.docs;
      if (weightDocs.isNotEmpty) {
        final DocumentReference weightDocRef = weightDocs.first.reference;
        await weightDocRef.update({'weight': weight, 'time': Timestamp.fromDate(now)});
      } else {
        await weightCollection.add({'weight': weight, 'time': Timestamp.fromDate(now)});
      }
      setState(() {
        _currentWeight = weight;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Weight saved')),
      );
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
          title: Text('BodyWeight',style: TextStyle(fontSize:15),),
          titleSpacing: -13,
          actions: [
            ElevatedButton.icon( onPressed:(){
                 Navigator.pushNamed(context, '/bodymeasurements');
            },
            style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 20),
                  primary:Colors.black,
                   padding: EdgeInsets.all(5),
                   alignment: Alignment.centerLeft
                ),
             icon: Icon(Icons.boy_rounded,color:Color(0xff45B39D)),
            label: Text('body Measurse',style: TextStyle(color: Colors.white),))
          ],
      ),
       body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              'Current weight: ${_currentWeight?.toString() ?? 'None'}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _handleSubmit(context),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}