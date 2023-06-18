import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Nut extends StatefulWidget {
  const Nut( {super.key,});

  @override
  State<Nut> createState() => _NutState();
}

class _NutState extends State<Nut> {
   late Stream<QuerySnapshot> _stream;


  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('nutritionData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .orderBy('date', descending: true)
        .snapshots();  
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
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
          title: Text('Nutrition',style: TextStyle(fontSize:16 ,),),
          titleSpacing: -13,
      ),
         body: Column(
           children: [
         
             Container(
       color: Color.fromARGB(255, 32, 32, 32),
        child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final List<DataRow> rows = snapshot.data!.docs.map((DocumentSnapshot document) {
                  final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  final int protein = data['protein'] ?? 0;
                  final int carbs = data['carbs'] ?? 0;
                  final int fat = data['fat'] ?? 0;
                  final int calories = data['calories'];
                  return DataRow(
                    cells: [
                      DataCell(Text(data['date'],style: TextStyle(
                                      color: Colors.grey,))),
                      DataCell(Text('$protein',style: TextStyle(
                                      color: Colors.grey,))),
                      DataCell(Text('$carbs',style: TextStyle(
                                      color: Colors.grey,))),
                      DataCell(Text('$fat',style: TextStyle(
                                      color: Colors.grey,))),
                      DataCell(Text('$calories',style: TextStyle(
                                      color: Colors.grey,))),
                    ],
                  );
                }).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Expanded(
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Date',style: TextStyle(
                                          color: Colors.white,))),
                              DataColumn(label: Text('Protein',style: TextStyle(
                                          color: Colors.white,))),
                              DataColumn(label: Text('Carbs',style: TextStyle(
                                          color: Colors.white,))),
                              DataColumn(label: Text('Fat',style: TextStyle(
                                          color: Colors.white,))),
                              DataColumn(label: Text('Calories',style: TextStyle(
                                          color: Colors.white,))),
                            ],
                            rows: rows,
                          ),
                        ),
                      ],
                    ),
                  
                );
              },
        ),
      ),

           ],
         ),
    );
  }
}