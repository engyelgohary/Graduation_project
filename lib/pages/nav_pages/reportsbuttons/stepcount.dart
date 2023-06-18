import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StepCount extends StatefulWidget {
  const StepCount({super.key});

  @override
  State<StepCount> createState() => _StepCountState();
}

class _StepCountState extends State<StepCount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _stepController;
  double? _currentStep;
  List<StepData> _stepDataList = [];

  @override
  void initState() {
    super.initState();
    _stepController = TextEditingController();
    _loadCurrentStep();
    _loadStepData();
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentStep() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot stepSnap = await _firestore
          .collection('Athletes')
          .doc(user.uid)
          .collection('steps')
          .orderBy('time', descending: true)
          .limit(1)
          .get();
      if (stepSnap.docs.isNotEmpty) {
        final DocumentSnapshot weightDoc = stepSnap.docs.first;
        setState(() {
          _currentStep = weightDoc['steps'].toDouble();
        });
        _stepController.text = _currentStep?.toDouble().toString() ?? '';
      }
    }
  }

  Future<void> _loadStepData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot stepSnap = await _firestore
          .collection('Athletes')
          .doc(user.uid)
          .collection('steps')
          .orderBy('time', descending: true)
          .get();
      final List<StepData> stepDataList = stepSnap.docs.map((doc) {
        return StepData(
          step: doc['steps'].toDouble(),
          time: doc['time'].toDate(),
        );
      }).toList();
      setState(() {
        _stepDataList = stepDataList;
      });
    }
  }

Future<void> _handleSubmit(BuildContext context) async {
  final String stepString = _stepController.text.trim();
  if (stepString.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter your step')),
    );
    return;
  }
  final double step = double.tryParse(stepString) ?? 0.0;
  if (step <= 0.0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid step')),
    );
    return;
  }
  final User? user = _auth.currentUser;
  if (user != null) {
    final CollectionReference stepCollection =
        _firestore.collection('Athletes').doc(user.uid).collection('steps');
    final DateTime now = DateTime.now();
    final QuerySnapshot stepSnap = await stepCollection
        .where('time', isEqualTo: Timestamp.fromDate(now))
        .get();
    if (stepSnap.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have already signed step data for this time.')),
      );
      return;
    }
    final QuerySnapshot lastStepSnap = await stepCollection
        .orderBy('time', descending: true)
        .limit(1)
        .get();
    if (lastStepSnap.docs.isNotEmpty) {
      final DocumentSnapshot lastStepDoc = lastStepSnap.docs.first;
      final DateTime lastTime = lastStepDoc['time'].toDate();
      if (now.year == lastTime.year &&
          now.month == lastTime.month &&
          now.day == lastTime.day) {
        await lastStepDoc.reference.update({'steps': step});
        setState(() {
          _currentStep = step;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Steps data updated for today.')),
        );
        _loadStepData();
        return;
      }
    }
    await stepCollection.add({'steps': step, 'time': Timestamp.fromDate(now)});
    setState(() {
      _currentStep = step;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Step data saved.')),
    );
    _loadStepData();
  }
}

  List<charts.Series<StepData, DateTime>> _createChartSeries() {
    return [
      charts.Series<StepData, DateTime>(
        id: 'steps',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff45B39D)),
        domainFn: (
          StepData data,
          _,
        ) =>
            data.time,
        measureFn: (StepData data, _) => data.step,
        data: _stepDataList,
      ),
    ];
  }

  double _calculateAverageStep() {
    if (_stepDataList.isEmpty) {
      return 0.0;
    }
    final totalStep = _stepDataList.fold<double>(
      0.0,
      (sum, data) => sum + data.step,
    );
    return totalStep / _stepDataList.length;
  }

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
          title: Text('Step Count',style: TextStyle(fontSize:16 ,),),
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
                          'Avg: ${_calculateAverageStep().toStringAsFixed(2)} Steps',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: charts.TimeSeriesChart(
                          _stepDataList.isEmpty
                              ? []
                              : [
                                  charts.Series<StepData, DateTime>(
                                    id: 'Steps',
                                    colorFn: (_, __) => charts
                                        .MaterialPalette.blue.shadeDefault,
                                    domainFn: (data, _) => data.time,
                                    measureFn: (data, _) => data.step,
                                    data: _stepDataList,
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
                      controller: _stepController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => _handleSubmit(context),
                          icon: Icon(
                            Icons.add,
                            color: Color(0xff45B39D),
                          ),
                        ),
                        hintText: 'Log daily steps',
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
                  'steps',
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
                            label: Text('Steps',
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ],
                      rows: _stepDataList.map((data) {
                        return DataRow(cells: [
                          DataCell(Text(
                              DateFormat('EEE, MMM d, y').format(data.time),
                              style: TextStyle(color: Colors.grey))),
                          DataCell(
                            Text(data.step.toString(),
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ]
        )
        )
    );
  }
}
class StepData {
  final double step;
  final DateTime time;

  StepData({required this.step, required this.time});
}