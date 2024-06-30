
import 'package:qldtandroid/models/answer_model.dart';

class AssignmentModel {
    String? id;
    String? idTest;
    List<String>? listIdAnswer;
    String? mssv;
    List<AnswerModel>? dataAnswersStudent;
    DateTime? createdAt;
    String? idAssignment;
    int? totalScore;
    int? v;

    AssignmentModel({
        this.id,
        this.idTest,
        this.listIdAnswer,
        this.mssv,
        this.dataAnswersStudent,
        this.createdAt,
        this.idAssignment,
        this.totalScore,
        this.v,
    });

    factory AssignmentModel.fromJson(Map<String, dynamic> json) => AssignmentModel(
        id: json["_id"],
        idTest: json["idTest"],
        listIdAnswer: List<String>.from(json["listIDAnswer"].map((x) => x)),
        mssv: json["mssv"],
        dataAnswersStudent: List<AnswerModel>.from(json["dataAnswersStudent"].map((x) => AnswerModel.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        idAssignment: json["idAssignment"],
        totalScore: json["totalScore"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "idTest": idTest,
        "mssv": mssv,
        "dataAnswersStudent": List<dynamic>.from(dataAnswersStudent!.map((x) => x.toJson())),
    };
}