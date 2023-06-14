// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
          _currentWeight = weightDoc['weight'].toDouble();
        });
        _weightController.text = _currentWeight?.toDouble().toString() ?? '';
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
          weight: doc['weight'].toDouble(),
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
      final CollectionReference weightCollection =
          _firestore.collection('Athletes').doc(user.uid).collection('weight');
      final DateTime now = DateTime.now();
      final QuerySnapshot weightSnap = await weightCollection
          .where('time',
              isGreaterThan:
                  Timestamp.fromDate(now.subtract(const Duration(days: 1))))
          .get();
      final List<QueryDocumentSnapshot> weightDocs = weightSnap.docs;
      if (weightDocs.isNotEmpty) {
        final DocumentReference weightDocRef = weightDocs.first.reference;
        await weightDocRef
            .update({'weight': weight, 'time': Timestamp.fromDate(now)});
      } else {
        await weightCollection
            .add({'weight': weight, 'time': Timestamp.fromDate(now)});
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

  List<charts.Series<WeightData, DateTime>> _createChartSeries() {
    return [
      charts.Series<WeightData, DateTime>(
        id: 'Weight',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff45B39D)),
        domainFn: (
          WeightData data,
          _,
        ) =>
            data.time,
        measureFn: (WeightData data, _) => data.weight,
        data: _weightDataList,
      ),
    ];
  }

  double _calculateAverageWeight() {
    if (_weightDataList.isEmpty) {
      return 0.0;
    }
    final totalWeight = _weightDataList.fold<double>(
      0.0,
      (sum, data) => sum + data.weight,
    );
    return totalWeight / _weightDataList.length;
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
                Image(image: AssetImage('images/logo.png'), height: 50),
              ],
            ),
          ),
        ),
        title: Text('BodyWeight', style: TextStyle(fontSize: 15)),
        titleSpacing: -13,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 32, 32, 32),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 250),
                        child: Text(
                          'Avg: ${_calculateAverageWeight().toStringAsFixed(2)} KG',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: charts.TimeSeriesChart(
                          _weightDataList.isEmpty
                              ? []
                              : [
                                  charts.Series<WeightData, DateTime>(
                                    id: 'Weight',
                                    colorFn: (_, __) => charts
                                        .MaterialPalette.blue.shadeDefault,
                                    domainFn: (data, _) => data.time,
                                    measureFn: (data, _) => data.weight,
                                    data: _weightDataList,
                                  ),
                                ],
                          animate: true,
                          dateTimeFactory: const charts.LocalDateTimeFactory(),
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            tickProviderSpec:
                                charts.StaticNumericTickProviderSpec([
                              charts.TickSpec(20),
                              charts.TickSpec(40),
                              charts.TickSpec(60),
                              charts.TickSpec(80),
                            ]),
                            renderSpec: charts.GridlineRendererSpec(
                              labelStyle: charts.TextStyleSpec(
                                color: charts.ColorUtil.fromDartColor(
                                    Colors.white),
                              ),
                              lineStyle: charts.LineStyleSpec(
                                color: charts.ColorUtil.fromDartColor(
                                    Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (_weightDataList.isNotEmpty) ...[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Start weight',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                'End weight',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                'Weight changes',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${_weightDataList.last.weight.toStringAsFixed(2)} KG\n',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                '${_weightDataList.first.weight.toStringAsFixed(2)} KG\n',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Text(
                                '${(_weightDataList.first.weight - _weightDataList.last.weight).toStringAsFixed(2)} KG',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 48, 50, 51),
                  ),
                  child: SizedBox(
                    width: 320,
                    height: 40,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => _handleSubmit(context),
                          icon: Icon(
                            Icons.add,
                            color: Color(0xff45B39D),
                          ),
                        ),
                        hintText: 'Log daily body weight',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 48, 50, 51),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff45B39D)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'KG',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: SizedBox(
                  width: 350,
                  child: Expanded(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                        DataColumn(
                            label: Text('KG',
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ],
                      rows: _weightDataList.map((data) {
                        return DataRow(cells: [
                          DataCell(Text(
                              DateFormat('EEE, MMM d, y').format(data.time),
                              style: TextStyle(color: Colors.grey))),
                          DataCell(
                            Text(data.weight.toString(),
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
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
