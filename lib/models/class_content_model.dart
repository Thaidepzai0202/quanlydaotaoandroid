import 'package:qldtandroid/models/student_model.dart';

class ClassContentModel {
  String? id;
  String classId;
  String mssv;
  double midScore;
  double finalScore;
  int? v;
  StudentModel? dataStudent;

  ClassContentModel({
    this.id,
    required this.classId,
    required this.mssv,
    required this.midScore,
    required this.finalScore,
    this.v,
    this.dataStudent,
  });

  factory ClassContentModel.fromJson(Map<String, dynamic> json) =>
      ClassContentModel(
        id: json["_id"],
        classId: json["classID"],
        mssv: json["mssv"],
        midScore: json["midScore"].toDouble(),
        finalScore: json["finalScore"].toDouble(),
        v: json["__v"],
        dataStudent: json["dataStudent"] == null
            ? null
            : StudentModel.fromJson(json["dataStudent"]),
      );

  Map<String, dynamic> toJson() => {
        "classID": classId,
        "mssv": mssv,
        "midScore": midScore,
        "finalScore": finalScore,
      };
}
