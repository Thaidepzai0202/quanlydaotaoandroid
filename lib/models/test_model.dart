
import 'package:qldtandroid/models/question_model.dart';

class TestModel {
  String classId;
  String testName;
  List<String>? listIdQuestion;
  List<Question>? dataQuestions;
  int? totalScore;
  DateTime startTime;
  DateTime endTime;
  DateTime? createdAt;
  String? idTest;
  int? statusTest;

  TestModel({
    required this.classId,
    required this.testName,
    this.listIdQuestion,
    this.dataQuestions,
    this.totalScore,
    required this.startTime,
    required this.endTime,
    this.createdAt,
    this.idTest,
    this.statusTest
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        classId: json["classID"],
        testName: json["testName"],
        listIdQuestion: List<String>.from(json["listIDQuestion"].map((x) => x)),
        dataQuestions: json["dataQuestions"] == null
            ? []
            : List<Question>.from(
                json["dataQuestions"].map((x) => Question.fromJson(x))),
        totalScore: json["totalScore"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        createdAt: DateTime.parse(json["createdAt"]),
        idTest: json["idTest"],
        statusTest: json["statusTest"],
      );

  Map<String, dynamic> toJson() => {
        "classID": classId,
        "testName": testName,
        "idTest": idTest,
        "dataQuestions":
            List<dynamic>.from(dataQuestions!.map((x) => x.toJson())),
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
      };
}

