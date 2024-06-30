class Question {
  String dataQuestion;
  int type;
  List<String> dataAnswers;
  List<String> dataCorrectAnswer;
  int score;
  DateTime? createdAt;
  String? idQuestion;

  Question(
      {required this.dataQuestion,
      required this.type,
      required this.dataAnswers,
      required this.dataCorrectAnswer,
      required this.score,
       this.createdAt,
       this.idQuestion});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      dataQuestion: json['dataQuestion'],
      type: json['type'],
      dataAnswers: json['dataAnswers']!=null ?  json['dataAnswers'].split('//') : [],
      dataCorrectAnswer: json['dataCorrectAnswer'].split('//') ??[],
      score: json['score'],
      createdAt: DateTime.parse(json["createdAt"]),
      idQuestion: json["idQuestion"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataQuestion': dataQuestion,
      'type': type,
      'dataAnswers': dataAnswers.join('//'),
      'dataCorrectAnswer': dataCorrectAnswer.join('//'),
      'score': score,
    };
  }
}
