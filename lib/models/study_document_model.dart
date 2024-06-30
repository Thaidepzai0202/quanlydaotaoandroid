class StudyDocumentModel {
    String? id;
    String? classId;
    String? dataLink;
    DateTime? createdAt;
    String? idStudy;
    int? v;

    StudyDocumentModel({
        this.id,
        this.classId,
        this.dataLink,
        this.createdAt,
        this.idStudy,
        this.v,
    });

    factory StudyDocumentModel.fromJson(Map<String, dynamic> json) => StudyDocumentModel(
        id: json["_id"],
        classId: json["classID"],
        dataLink: json["dataLink"],
        createdAt: DateTime.parse(json["createdAt"]),
        idStudy: json["idStudy"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "classID": classId,
        "dataLink": dataLink,
    };
}