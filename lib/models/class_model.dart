

import 'package:qldtandroid/models/subject_model.dart';
import 'package:qldtandroid/models/teacher_model.dart';

class ClassRoomModel {
    String className;
    String classId;
    String mscb;
    String subjectId;
    String dayOfWeek;
    String classSession;
    int maxStudent;
    int? currentStudent;
    String? semester;
    SubjectModel? dataSubject;
    TeacherModel? dataTeacher;

    ClassRoomModel({
        required this.className,
        required this.classId,
        required this.mscb,
        required this.subjectId,
        required this.dayOfWeek,
        required this.classSession,
        this.semester,
        this.dataSubject,
        required this.maxStudent,
        this.currentStudent,
        this.dataTeacher
    });

    factory ClassRoomModel.fromJson(Map<String, dynamic> json) => ClassRoomModel(
        className: json["className"],
        classId: json["classID"],
        mscb: json["mscb"],
        subjectId: json["subjectID"],
        dayOfWeek: json["dayOfWeek"],
        classSession: json["classSession"],
        semester: json["semester"],
        maxStudent: json["maxStudent"],
        currentStudent: json["currentStudent"],
        dataSubject: json["dataSubject"] ==null ? null : SubjectModel.fromJson(json["dataSubject"]),
        dataTeacher: json["dataTeacher"] ==null ? null : TeacherModel.fromJson(json["dataTeacher"])
    );

    Map<String, dynamic> toJson() => {
        "className": className,
        "mscb": mscb,
        "subjectID": subjectId,
        "dayOfWeek": dayOfWeek,
        "classSession": classSession,
        "maxStudent" : maxStudent
    };
}
