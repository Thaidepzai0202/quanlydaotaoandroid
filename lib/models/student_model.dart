

class StudentModel {
    String mssv;
    String name;
    String gender;
    String email;
    String password;
    String className;
    String course;

    StudentModel({
        required this.mssv,
        required this.name,
        required this.gender,
        required this.email,
        required this.password,
        required this.className,
        required this.course,
    });

    factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        mssv: json["mssv"],
        name: json["name"],
        gender: json["gender"],
        email: json["email"],
        password: json["password"],
        className: json["className"],
        course: json["course"],
    );

    Map<String, dynamic> toJson() => {
        "mssv": mssv,
        "name": name,
        "gender": gender,
        "email": email,
        "password": password,
        "className": className,
        "course": course,
    };
}
