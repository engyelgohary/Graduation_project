import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/Day.dart';
import '../../models/Program.dart';
import '../../models/Workout.dart';
import '../../models/block.dart';
import '../../models/set.dart';

openBrowserTab(String link) async {
  if (link == "") {
    Fluttertoast.showToast(msg: "No Link Found");
  } else {
    await FlutterWebBrowser.openWebPage(
      customTabsOptions:
          const CustomTabsOptions(colorScheme: CustomTabsColorScheme.dark),
      url: link,
    );
  }
}

Future<List<Workout>> getWorkout() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    log(user!.uid);
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('workout')
            // .doc("f7f9c0a0-10b1-11ee-a2a8-23b6abbced55")
            .get();
    List<Workout> workout = snapshot.docs
        .map((e) => Workout.fromJson(e.data()))
        .where((element) => element.athleteId == user.uid)
        .toList();
    if (workout != null || workout.isNotEmpty) {
      return workout;
    } else {
      return [];
    }
  } catch (e) {
    print('Error get document: ${e.toString()}');
    return [];
  }
}

Future<List<SetExersice>> getSet() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('sets').get();
    return snapshot.docs.map((e) => SetExersice.fromJson(e.data())).toList();
  } catch (e) {
    print('Error get document: ${e.toString()}');
    return [];
  }
}

Future<List<Program>> getProgram() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('program').get();
    return snapshot.docs.map((e) => Program.fromJson(e.data())).toList();
  } catch (e) {
    print('Error get document: ${e.toString()}');
    return [];
  }
}

Future<List<Day>> getDay() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('day').get();
    return snapshot.docs.map((e) => Day.fromJson(e.data())).toList();
  } catch (e) {
    print('Error get document: ${e.toString()}');
    return [];
  }
}

Future<List<Block>> getBlock() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('block').get();
    return snapshot.docs.map((e) => Block.fromJson(e.data())).toList();
  } catch (e) {
    print('Error get document: ${e.toString()}');
    return [];
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<bool> isEdit = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController linkController = TextEditingController();
  TextEditingController rpeController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late List<Workout> workout;
  late List<SetExersice> set;
  late List<Day> day;
  late List<Block> block;
  late List<Program> program;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  Future<void> updateData({
    required id,
    required setId,
    required String rpe,
    required String reps,
    required String link,
    required notes,
    required intensity,
    required load,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('workout')
          .doc(id.toString())
          .update({
        "data": [
          {
            "id": setId,
            "workoutId": id,
            "reps": reps,
            "notes": notes,
            "RPE": rpe,
            "link": link,
            "intensity": intensity,
            "load": load,
            "done": true,
          }
        ]
      }).then((value) {
        loadData();
      });
    } catch (e) {
      print('Error Update data: ${e.toString()}');
    }
  }

  bool isLoading = false;

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      workout = await getWorkout();
      // set = await getSet();
      // day = await getDay();
      // block = await getBlock();
      // program = await getProgram();
      for (var i = 0; i < workout[0].data!.length; i++) {
        isEdit.add(false);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading coach name: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: const Color(0xff181818),
        elevation: 0,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              color: Color(0xff5bc500),
            ))
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: workout.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Text(
                              'No workouts added yet!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  // SetExersice set = SetExersice(
                                  //   id: '2',
                                  //   workoutId:
                                  //       'f7f9c0a0-10b1-11ee-a2a8-23b6abbced55',
                                  //   reps: '6',
                                  //   intensity: '70%',
                                  //   load: '75kg',
                                  //   RPE: '',
                                  //   done: false,
                                  //   link: '',
                                  //   notes:
                                  //       'Work up to 75% and perform 2 sets of 6-8 @8',
                                  // );
                                  // await FirebaseFirestore.instance
                                  //     .collection('workout')
                                  //     .doc(
                                  //         "f7f9c0a0-10b1-11ee-a2a8-23b6abbced55")
                                  //     .update({
                                  //   "data": FieldValue.arrayUnion([
                                  //     {
                                  //       "id": set.id,
                                  //       "workoutId": set.workoutId,
                                  //       "reps": set.reps,
                                  //       "notes": set.notes,
                                  //       "RPE": set.RPE,
                                  //       "link": set.link,
                                  //       "intensity": set.intensity,
                                  //       "load": set.load,
                                  //       "done": set.done,
                                  //     }
                                  //   ])
                                  // });
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xff5bc500))),
                                child: Text(
                                  'Add Workout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                          ],
                        ),
                      )
                    : ListView(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Wrap(
                                  children: [
                                    Text(
                                      'Workout ${index + 1}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      padding: const EdgeInsets.all(12.0),
                                      color: const Color(0xff454545),
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          itemBuilder: (context, indexx) {
                                            return workOutItem(
                                                context,
                                                index,
                                                indexx,
                                                workout[index].data![indexx]);
                                          },
                                          separatorBuilder: (context, index) =>
                                              const Divider(
                                                color: Color(0xff181818),
                                                thickness: 1,
                                                height: 50,
                                              ),
                                          itemCount:
                                              workout[index].data!.length),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 15),
                              itemCount: workout.length),
                        ],
                      ),
              ),
            ),
    );
  }

  Widget workOutItem(context, index, indexx, SetExersice model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.chat,
              color: Colors.deepPurple[800],
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              model.notes,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xff5bc500))),
                padding: const EdgeInsets.all(5),
                child: const Text('A',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600))),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              color: Colors.grey.shade700,
              child: const Text('Squat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ),
            const Spacer(),
            if (model.done != true)
              GestureDetector(
                onTap: () {
                  if (rpeController.text.isEmpty &&
                      linkController.text.isEmpty) {
                    setState(() {
                      isEdit[indexx] = !isEdit[indexx];
                    });
                  } else {
                    if (_formKey.currentState!.validate()) {
                      updateData(
                          id: workout[index].id,
                          rpe: rpeController.text,
                          link: linkController.text,
                          setId: model.id,
                          reps: model.reps,
                          notes: model.notes,
                          intensity: model.intensity,
                          load: model.load);
                    } else {
                      Get.snackbar('Error', 'Something went wrong !');
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0xff5bc500))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        isEdit[indexx] == false ? 'Edit' : 'Done',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 5),
                      Icon(
                          isEdit[indexx] == false
                              ? Icons.edit_square
                              : Icons.done,
                          color: Colors.white,
                          size: 12)
                    ],
                  ),
                ),
              )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            customNumber(context, title: 'Sets', value: '2'),
            customNumber(context, title: 'Reps', value: model.reps),
            customNumber(context, title: 'RPE', value: model.RPE),
            customNumber(context, title: 'Load', value: model.load),
            customNumber(context, title: 'Intensty', value: model.intensity),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Link',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        openBrowserTab(model.link);
                      },
                      child: Text(
                        model.link,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        if (model.done != true)
          if (isEdit[indexx] == true)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('*',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an RPE';
                        }
                        return null;
                      },
                      controller: rpeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: "RPE",
                          labelStyle:
                              TextStyle(fontSize: 14, color: Colors.white),
                          prefixIcon: Icon(
                            Icons.fitness_center_sharp,
                            color: Color(0xff5bc500),
                            size: 18,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff5bc500)),
                          ))),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: linkController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: "Link",
                          labelStyle:
                              TextStyle(fontSize: 14, color: Colors.white),
                          prefixIcon: Icon(
                            Icons.link_sharp,
                            color: Color(0xff5bc500),
                            size: 18,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff5bc500)),
                          ))),
                ),
              ],
            ),
      ],
    );
  }

  Widget customNumber(context, {required title, required value}) => Expanded(
        flex: 2,
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
}
