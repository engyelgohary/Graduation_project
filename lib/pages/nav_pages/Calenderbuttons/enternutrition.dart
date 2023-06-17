import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class NutritionData {
  final String nutrient;
  final int amount;

  NutritionData(this.nutrient, this.amount);
}

class Enter_Nut extends StatefulWidget {
  const Enter_Nut({super.key});

  @override
  State<Enter_Nut> createState() => _Enter_NutState();
}

class _Enter_NutState extends State<Enter_Nut> {
    final _formKey = GlobalKey<FormState>();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  

  @override
  void dispose() {
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
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
          title: Text('Nutrition',style: TextStyle(fontSize:14),maxLines:2,),
          titleSpacing: -13,
          actions: [
            ElevatedButton.icon( onPressed:(){
               Navigator.pushNamed(context, '/nutrition');
            },
            style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 60),
                  primary:Colors.black,
                   padding: EdgeInsets.all(15),
                   alignment: Alignment.centerLeft
                ),
             icon: Icon(Icons.history_sharp,color:Color(0xff45B39D)),
            label: Text('Nutrition Log',style: TextStyle(color: Color(0xff45B39D)),))
          ],
      ),
      body: SingleChildScrollView(
        child:Padding(
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
                      Text('Protein (g)',style: TextStyle(fontSize: 15,color: Colors.white),),
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
                            fillColor:  Color.fromARGB(255, 25, 25, 26),
                     
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
                       Text('Carbs (g)',style: TextStyle(fontSize: 15,color: Colors.white),),
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
                            fillColor:  Color.fromARGB(255, 25, 25, 26),
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
                height:50 ,
                width: 600,
                child: Container(
                   padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 48, 50, 51),
                    ),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   Text('Fat (g)',style: TextStyle(fontSize: 15,color: Colors.white),),
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
                              fillColor:  Color.fromARGB(255, 25, 25, 26),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _addNutritionData();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),


      ) ,
    );
  }
  Future<void> _addNutritionData() async {
  final protein = int.parse(_proteinController.text);
  final carbs = int.parse(_carbsController.text);
  final fat = int.parse(_fatController.text);

  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final athleteId = user.uid;
    
    // Check if there is already a document for the current date in the nutrition subcollection
    final today = DateTime.now();
    final nutritionRef = FirebaseFirestore.instance
        .collection('Athletes')
        .doc(athleteId)
        .collection('nutrition')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(today.year, today.month, today.day)))
        .where('timestamp', isLessThan: Timestamp.fromDate(DateTime(today.year, today.month, today.day + 1)))
        .limit(1);
    final existingNutritionDocs = await nutritionRef.get();
    
    if (existingNutritionDocs.docs.isNotEmpty) {
      // Update the existing document with the new nutrition data
      final existingDoc = existingNutritionDocs.docs.single;
      await existingDoc.reference.update({
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'timestamp': Timestamp.now(),
      });
      
      print('Nutrition data updated for athlete $athleteId');
      
      // Show a SnackBar with the message "Nutrition data updated"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nutrition data updated'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      try {
        // Add a new document to the "nutrition" collection under the athlete's ID
        await FirebaseFirestore.instance
            .collection('Athletes')
            .doc(athleteId)
            .collection('nutrition')
            .add({
          'protein': protein,
          'carbs': carbs,
          'fat': fat,
          'timestamp': Timestamp.now(),
        });

        print('Nutrition data added for athlete $athleteId');
        
        // Show a SnackBar with the message "Nutrition data saved"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nutrition data saved'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (error) {
        print('Error adding nutrition data: $error');
      }
    }
  }
}
}
