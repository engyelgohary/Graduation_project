import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class NutritionData {
  final String nutrient;
  final int value;

  NutritionData(this.nutrient, this.value);
}

class EnterNutrition extends StatefulWidget {
  const EnterNutrition({Key? key}) : super(key: key);

  @override
  _EnterNutritionState createState() => _EnterNutritionState();
}

class _EnterNutritionState extends State<EnterNutrition> {
  final _formKey = GlobalKey<FormState>();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  late List<NutritionData> _chartData = [];
  late bool _hasSubmittedToday = false;

  @override
  void dispose() {
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    addNutritionData();
  }

  Future<void> addNutritionData() async {
    if (_formKey.currentState?.validate() ?? false) {
      final int protein = int.tryParse(_proteinController.text) ?? 0;
      final int carbs = int.tryParse(_carbsController.text) ?? 0;
      final int fat = int.tryParse(_fatController.text) ?? 0;

      NutritionData proteinData = NutritionData('Protein', protein);
      NutritionData carbsData = NutritionData('Carbs', carbs);
      NutritionData fatData = NutritionData('Fat', fat);

      setState(() {
        _chartData = [proteinData, carbsData, fatData];
      });

      // Add data to Firestore
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final DocumentReference docRef = FirebaseFirestore.instance
            .collection('nutritionData')
            .doc(user.uid)
            .collection('data')
            .doc(today);
        final DocumentSnapshot doc = await docRef.get();
        if (doc.exists) {
          // Data has already been submitted today
          setState(() {
            _hasSubmittedToday = true;
          });
          return;
        }
        await docRef.set({
          'protein': protein,
          'carbs': carbs,
          'fat': fat,
          'timestamp': Timestamp.now(),
        });

        // Update chart data
        final DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
        final String yesterdayStr = DateFormat('yyyy-MM-dd').format(yesterday);
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('nutritionData')
            .doc(user.uid)
            .collection('data')
            .where('date', isEqualTo: yesterdayStr)
            .get();
        if (snapshot.size > 0) {
          final DocumentSnapshot doc = snapshot.docs.first;
          final Map<String, dynamic> dataMap =
              doc.data() as Map<String, dynamic>;
          setState(() {
            _chartData = [
              NutritionData('Protein', dataMap['protein']),
              NutritionData('Carbs', dataMap['carbs']),
              NutritionData('Fat', dataMap['fat']),
            ];
          });
        }

        // Show snackbar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data saved successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
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
        title: Text(
          'Nutrition',
          style: TextStyle(fontSize: 14),
          maxLines: 2,
        ),
        titleSpacing: -13,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/nutrition');
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 60),
                primary: Colors.black,
                padding: EdgeInsets.all(15),
                alignment: Alignment.centerLeft),
            icon: Icon(Icons.history_sharp, color: Color(0xff45B39D)),
            label: Text(
              'Nutrition Log',
              style: TextStyle(color: Color(0xff45B39D)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 600,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 48, 50, 51),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Protein (g)',
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                        SizedBox(
                          height: 40,
                          width: 90,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _proteinController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 25, 25, 26),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 48, 50, 51),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff45B39D)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 600,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 48, 50, 51),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Carbs (g)',
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        ),
                        SizedBox(
                          height: 40,
                          width: 90,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                            controller: _carbsController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 25, 25, 26),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 48, 50, 51),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff45B39D)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 600,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 48, 50, 51),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fat (g)',
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                        SizedBox(
                          height: 40,
                          width: 90,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                            controller: _fatController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 25, 25, 26),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 48, 50, 51),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff45B39D)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff45B39D),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _hasSubmittedToday ? null : addNutritionData,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Summary Day',
                  style: TextStyle(fontSize: 20, color: Color(0xff45B39D)),
                ),
                SizedBox(height: 20),
                Container(
                  height: 300,
                  child: charts.BarChart(
                    [
                      charts.Series<NutritionData, String>(
                        id: 'Nutrients',
                        domainFn: (NutritionData nutrient, _) =>
                            nutrient.nutrient,
                        measureFn: (NutritionData nutrient, _) =>
                            nutrient.value,
                        colorFn: (NutritionData nutrient, _) =>
                            nutrient.nutrient == 'Protein'
                                ? charts.MaterialPalette.blue.shadeDefault
                                : nutrient.nutrient == 'Carbs'
                                    ? charts.MaterialPalette.green.shadeDefault
                                    : charts.MaterialPalette.red.shadeDefault,
                        data: _chartData,
                      )
                    ],
                    animate: true,
                    vertical: false,
                    barRendererDecorator: charts.BarLabelDecorator<String>(),
                    domainAxis: charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelRotation: 60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
