class AttendanceModel {
    String? classId;
    String? mssv;
    List<int>? dataAttendance;
    String? id;
    int? lock;
    int? v;
    String? name;

    AttendanceModel({
        this.classId,
        this.mssv,
        this.dataAttendance,
        this.id,
        this.lock,
        this.v,
        this.name
    });

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
        classId: json["classID"],
        mssv: json["mssv"],
        dataAttendance: List<int>.from(json["dataAttendance"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        lock: json["lock"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "classID": classId,
        "mssv": mssv,
        "dataAttendance": List<dynamic>.from(dataAttendance!.map((x) => x)),
    };
}