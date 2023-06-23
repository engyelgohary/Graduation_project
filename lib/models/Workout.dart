import 'package:flutterdatabasesalah/models/set.dart';

class Workout {
  String? id;
  String? dayId;
  String? exerciseId;
  String? coachId;
  String? athleteId;
  List<SetExersice>? data;

  Workout({
    this.id,
    this.exerciseId,
    this.dayId,
    this.data,
    this.coachId,
    this.athleteId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> item = <String, dynamic>{};
    item['id'] = id;
    item['dayId'] = dayId;
    item['coachId'] = coachId;
    item['dayId'] = dayId;
    item['athleteId'] = athleteId;
    if (data != null) {
      item['data'] = data!.map((v) => v.toJson()).toList();
    }
    item['blockId'] = dayId;
    return item;
  }

  Workout.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    dayId = json['dayId'] ?? '';
    coachId = json['coachId'] ?? '';
    athleteId = json['athleteId'] ?? '';
    if (json['data'] != null) {
      data = <SetExersice>[];
      json['data'].forEach((v) {
        data!.add(SetExersice.fromJson(v));
      });
    } else {
      data = [];
    }

    // exerciseId = json['exerciseId'] ?? '';
  }
}
