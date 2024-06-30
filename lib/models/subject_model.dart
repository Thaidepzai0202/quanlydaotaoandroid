class SubjectModel {
    String subjectName;
    String subjectId;
    int credit;

    SubjectModel({
        required this.subjectName,
        required this.subjectId,
        required this.credit,
    });

    factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        subjectName: json["subjectName"],
        subjectId: json["subjectID"],
        credit: json["credit"],
    );

    Map<String, dynamic> toJson() => {
        "subjectName": subjectName,
        "subjectID": subjectId,
        "credit": credit,
    };
}