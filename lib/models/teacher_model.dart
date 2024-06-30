
class TeacherModel {
    String name;
    String mscb;
    String gender;
    String email;
    String password;
    String position;
    String faculty;

    TeacherModel({
        required this.name,
        required this.mscb,
        required this.gender,
        required this.email,
        required this.password,
        required this.position,
        required this.faculty,
    });

    factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        name: json["name"],
        mscb: json["mscb"],
        gender: json["gender"],
        email: json["email"],
        password: json["password"],
        position: json["position"],
        faculty: json["faculty"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "mscb": mscb,
        "gender": gender,
        "email": email,
        "password": password,
        "position": position,
        "faculty": faculty,
    };
}
