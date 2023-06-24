import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BodyMeasurements {
  final double neck;
  final double chest;
  final double leftArm;
  final double rightArm;
  final double waist;
  final double hips;
  final double leftThigh;
  final double rightThigh;
  final DateTime timestamp;

  BodyMeasurements({
    required this.neck,
    required this.chest,
    required this.leftArm,
    required this.rightArm,
    required this.waist,
    required this.hips,
    required this.leftThigh,
    required this.rightThigh,
    required this.timestamp,
  });
}

class BodyM extends StatefulWidget {
  const BodyM({super.key});

  @override
  State<BodyM> createState() => _BodyMState();
}

class _BodyMState extends State<BodyM> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
late TextEditingController _neckController = TextEditingController();
   late TextEditingController _chestController = TextEditingController() ;
    late TextEditingController _leftarmController  = TextEditingController();
      late TextEditingController _rightarmController = TextEditingController();
    late TextEditingController _waistController = TextEditingController();
    late TextEditingController _hipsController = TextEditingController();
   late TextEditingController _leftthighController = TextEditingController();
    late TextEditingController _rightthighController = TextEditingController();
      late TextEditingController _leftcalfController = TextEditingController();
    late TextEditingController _rightcalfController = TextEditingController();
 @override
  void dispose() {
   _neckController.dispose();
   _chestController.dispose();
   _leftarmController.dispose();
   _rightarmController.dispose();
   _waistController.dispose();
   _hipsController.dispose();
   _leftthighController.dispose();
   _rightthighController.dispose();
   _leftcalfController.dispose();
   _rightcalfController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(BuildContext context) async {
       final String neckString = _neckController.text.trim();
         final String chestString = _chestController.text.trim();
         final String leftarmString = _leftarmController.text.trim();
        final String rightarmString = _rightarmController.text.trim();
         final String waistString = _waistController.text.trim();
     final String hipsString = _hipsController.text.trim();
        final String leftthighString = _leftthighController.text.trim();
        final String rightthighString = _rightarmController.text.trim();
        final String leftcalfString = _leftcalfController.text.trim();
         final String rightcalfString = _rightcalfController.text.trim();
    if (neckString.isEmpty && chestString.isEmpty && leftarmString.isEmpty 
    && rightarmString.isEmpty &&  waistString.isEmpty && hipsString.isEmpty
    && leftthighString.isEmpty && rightthighString.isEmpty && leftcalfString.isEmpty
    && rightcalfString.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your weight')),
      );
      return;
    }
      final double neck = double.tryParse(neckString) ?? 0.0;
      final double chest = double.tryParse(chestString) ?? 0.0;
      final double leftarm = double.tryParse(leftarmString) ?? 0.0;
      final double rightarm = double.tryParse(rightarmString) ?? 0.0;
       final double waist= double.tryParse(waistString) ?? 0.0;
      final double hips = double.tryParse(hipsString) ?? 0.0;
      final double leftthigh = double.tryParse(leftthighString) ?? 0.0;
      final double rightthigh = double.tryParse(rightthighString) ?? 0.0;
    if (neck <= 0.0 && chest <= 0.0 && leftarm <= 0.0 && rightarm <= 0.0 && 
    waist <= 0.0 && hips <= 0.0 && leftthigh <= 0.0 && rightthigh <=0.0
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid weight')),
      );
      return;
    }
    final User? user = _auth.currentUser;
    if (user != null) {
      final CollectionReference measuresCollection =
          _firestore.collection('Athletes').doc(user.uid).collection('measures');
      final DateTime now = DateTime.now();
      final QuerySnapshot measuresSnap = await measuresCollection
          .where('time',
              isGreaterThan:
                  Timestamp.fromDate(now.subtract(const Duration(days: 1))))
          .get();
      final List<QueryDocumentSnapshot> measuresDocs = measuresSnap.docs;
      if (measuresDocs.isNotEmpty) {
        final DocumentReference measuresDocRef = measuresDocs.first.reference;
        await measuresDocRef
            .update({'neck': neck,
            'chest': chest,
            'leftarm': leftarm,
            'rightarm': rightarm,
            'waist': waist,
            'hips': hips,
            'leftthigh': leftthigh,
            'rightthigh': rightthigh,
             'time': Timestamp.fromDate(now)});
      } else {
        await measuresCollection
            .add({'neck': neck,
            'chest': chest,
            'leftarm': leftarm,
            'rightarm': rightarm,
            'waist': waist,
            'hips': hips,
            'leftthigh': leftthigh,
            'rightthigh': rightthigh,
             'time': Timestamp.fromDate(now)});
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('data saved')),
      );
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
              Image(
                image: AssetImage('images/logo.png'),
                height: 40,
              ),
            ],
          ),
        )),
        title: Text(
          'Measures',
          style: TextStyle(fontSize: 14),
          maxLines: 2,
        ),
        titleSpacing: -13,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/Measureshistory');
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 60),
                  primary: Colors.black,
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerLeft),
              icon: Icon(Icons.history_sharp, color: Color(0xff45B39D)),
              label: Text(
                'History',
                style: TextStyle(color: Color(0xff45B39D)),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column( 
            children:[
               SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/measure');
                          },
                          child: Text(
                            'How to measure',
                            style: TextStyle(color:(Color(0xff45B39D)),fontSize: 18,
                          )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Neck (cm)',
                            style: TextStyle(fontSize: 15,color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _neckController,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontSize: 14,),
                             textInputAction: TextInputAction.next,
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
                    height: 10,
                  ),
                    SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chest (cm)',
                            style: TextStyle(fontSize: 15, color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _chestController,
                               textInputAction: TextInputAction.next,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontSize: 14,),
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Left Arm (cm)',
                            style: TextStyle(fontSize: 15, color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _leftarmController,
                              textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 14,),
                             textInputAction: TextInputAction.next,
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Right Arm (cm)',
                            style: TextStyle(fontSize: 15,color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _rightarmController,
                              textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 14,),
                             textInputAction: TextInputAction.next,
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Waist (Cm)',
                            style: TextStyle(fontSize: 15, color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _waistController,
                              textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 14,),
                             textInputAction: TextInputAction.next,
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
                    height: 10,
                  ),
                     SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hips (cm)',
                            style: TextStyle(fontSize: 15,color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _hipsController,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontSize: 14,),
                             textInputAction: TextInputAction.next,
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
                    height: 10,
                  ),
                    SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Left Thigh (cm)',
                            style: TextStyle(fontSize: 15, color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _leftthighController,
                               textInputAction: TextInputAction.next,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontSize: 14,),
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Right Thigh (cm)',
                            style: TextStyle(fontSize: 15, color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _rightthighController,
                              textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 14,),
                             textInputAction: TextInputAction.next,
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Left Calf (cm)',
                            style: TextStyle(fontSize: 15, color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _leftcalfController,
                              textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 14,),
                             textInputAction: TextInputAction.next,
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 40,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 48, 50, 51),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Right Calf (cm)',
                            style: TextStyle(fontSize: 15,color:(Color(0xff45B39D))),
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                               textInputAction: TextInputAction.done,
                              textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 14,),
                            controller: _rightcalfController,
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
             ElevatedButton(
                    onPressed:() => _handleSubmit(context),
                    child: Text(
                            'save',
                            style: TextStyle(fontSize: 18),
                          ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(380, 40)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff45B39D)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
            ]

          ),
        )
        ),
    );
  }
}