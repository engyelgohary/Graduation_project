import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History ({super.key,});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _measuresData = [];

  @override
  void initState() {
    super.initState();
    _fetchMeasuresData();
  }

  Future<void> _fetchMeasuresData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot measuresSnap = await _firestore
          .collection('Athletes')
          .doc(user.uid)
          .collection('measures')
          .orderBy('time', descending: true)
          .get();
      final List<QueryDocumentSnapshot> measuresDocs = measuresSnap.docs;
      setState(() {
        _measuresData = measuresDocs
    .map((doc) => doc.data() as Map<String, dynamic>)
    .toList();
      });
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
           padding: EdgeInsets.only(top: 12),
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image(image: AssetImage('images/logo.png'),height: 40,),
            ],
           ),
        )
        ),
          title: Text('Photo History',style: TextStyle(fontSize:16 ,),),
          titleSpacing: -13,
      ),
      body: 
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Expanded(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Date',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Neck',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Chest',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Left Arm',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Right Arm',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Waist',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Hips',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Left Thigh',style: TextStyle(
                              color: Colors.white,
                            ))),
              DataColumn(label: Text('Right Thigh',style: TextStyle(
                              color: Colors.white,
                            ))),
            ],
            rows: _measuresData
                .map((data) => DataRow(cells: [
                      DataCell(Text(data['time'].toDate().toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['neck'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['chest'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['leftarm'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['rightarm'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['waist'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['hips'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['leftthigh'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                      DataCell(Text(data['rightthigh'].toString(),style: TextStyle(
                        color: Colors.grey,
                      ))),
                    ]))
                .toList(),
          ),
        ),
      ),
    );
  }
}