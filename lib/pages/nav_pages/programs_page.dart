import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Day.dart';
import '../../models/Program.dart';
import '../../models/Workout.dart';
import '../../models/block.dart';
import '../../models/set.dart';

Future<List<Workout>> getWorkout() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('workout').get();
    return snapshot.docs.map((e) => Workout.fromJson(e.data())).toList();
  } catch (e) {
    print('Error get document: ${e.toString()}');
    return [];
  }
}

Future<List<setExersice>> getSet() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('sets').get();
    return snapshot.docs.map((e) => setExersice.fromJson(e.data())).toList();
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController linkController = TextEditingController();
  TextEditingController rpeController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late List<Workout> workout;
  late List<setExersice> set;
  late List<Day> day;
  late List<Block> block;
  late List<Program> program;
  bool isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> updateData({
    required id,
    required String rpe,
    required String link,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('sets')
          .doc(id.toString())
          .update({
        "RPE": rpe,
        "link": link,
        "done": true,
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
      set = await getSet();
      day = await getDay();
      block = await getBlock();
      program = await getProgram();

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
        // title: const Text('Back'),
        backgroundColor: const Color(0xff181818),
        elevation: 0,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
              color: Color(0xff5bc500),
            ))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    'Workout ${workout.length}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    color: const Color.fromARGB(255, 50, 50, 50),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            workOutItem(context, set[index]),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: set.length),
                  ),
                ],
              ),
            ),
    );
  }

  Widget workOutItem(context, setExersice model) => Form(
        key: _formKey,
        child: Column(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
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
                          isEdit = !isEdit;
                        });
                      } else {
                        if (_formKey.currentState!.validate()) {
                          updateData(
                              id: model.id,
                              rpe: rpeController.text,
                              link: linkController.text);
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            isEdit == false ? 'Edit' : 'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 5),
                          Icon(isEdit == false ? Icons.edit_square : Icons.done,
                              color: Colors.white, size: 12)
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const SizedBox(
                //   width: 5,
                // ),
                customNumber(context, title: 'Sets', value: '2'),
                customNumber(context, title: 'Reps', value: model.reps),
                customNumber(context, title: 'RPE', value: model.RPE),
                customNumber(context, title: 'Load', value: '${model.load}kg'),
                customNumber(context,
                    title: 'Intensty', value: '${model.intensity}'),
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
                          onTap: () {},
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
                // const SizedBox(
                //   width: 150,
                // ),
              ],
            ),
            if (model.done != true)
              if (isEdit == true)
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
                                borderSide:
                                    BorderSide(color: Color(0xff5bc500)),
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
                                borderSide:
                                    BorderSide(color: Color(0xff5bc500)),
                              ))),
                    ),
                  ],
                ),
          ],
        ),
      );

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
