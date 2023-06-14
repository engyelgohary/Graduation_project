// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Enter_Weight extends StatefulWidget {
  const Enter_Weight({Key? key}) : super(key: key);

  @override
  State<Enter_Weight> createState() => _Enter_WeightState();
}

class _Enter_WeightState extends State<Enter_Weight> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _weightController;
  double? _currentWeight;
  List<WeightData> _weightDataList = [];

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _loadCurrentWeight();
    _loadWeightData();
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

  Future<void> _loadWeightData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot weightSnap = await _firestore
          .collection('Athletes')
          .doc(user.uid)
          .collection('weight')
          .orderBy('time', descending: true)
          .get();
      final List<WeightData> weightDataList = weightSnap.docs.map((doc) {
        return WeightData(
          weight: doc['weight'],
          time: doc['time'].toDate(),
        );
      }).toList();
      setState(() {
        _weightDataList = weightDataList;
      });
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
      _loadWeightData();
    }
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
                Image(image: AssetImage('images/logo.png'), height: 40),
              ],
            ),
          ),
        ),
        title: Text('BodyWeight', style: TextStyle(fontSize: 15)),
        titleSpacing: -13,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/bodymeasurements');
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 20),
                  primary:Colors.black,
                  elevation: 0),
              icon: Icon(Icons.add_sharp, size: 15),
              label: Text('Body Measurements', style: TextStyle(fontSize: 12))),
        
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Weight', style: TextStyle(fontSize: 25, color: Colors.white)),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Enter weight',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _handleSubmit(context),
                  child: Text('Save'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Weight History', style: TextStyle(fontSize: 25, color: Colors.white)),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Weight (kg)')),
                  ],
                  rows: _weightDataList.map((data) {
                    return DataRow(cells: [
                      DataCell(Text(DateFormat('EEE, MMM d, y').format(data.time))),
                      DataCell(Text(data.weight.toString())),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeightData {
  final double weight;
  final DateTime time;

  WeightData({required this.weight, required this.time});
}