

class AnswerModel {
    String? id;
    String? idQuestion;
    String? mssv;
    List<String>? dataAnswers;
    DateTime? createdAt;
    String? idAnswer;
    int? score;
    int? type;
    int? v;

    AnswerModel({
        this.id,
        this.idQuestion,
        this.mssv,
        this.dataAnswers,
        this.createdAt,
        this.idAnswer,
        this.score,
        this.type,
        this.v,
    });

    factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        id: json["_id"],
        idQuestion: json["idQuestion"],
        mssv: json["mssv"],
        dataAnswers: json["dataAnswers"].split("//"),
        createdAt: DateTime.parse(json["createdAt"]),
        idAnswer: json["idAnswer"],
        score: json["score"],
        type: json["type"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "idQuestion": idQuestion,
        "mssv": mssv,
        "dataAnswers": dataAnswers!.join("//"),
    };
}
