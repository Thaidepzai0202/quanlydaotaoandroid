class LeaveRequestModel {
    int? id;
    String? mssv;
    String? studentName;
    String? classId;
    String? reason;
    DateTime? createdAt;

    LeaveRequestModel({
        this.id,
        this.mssv,
        this.studentName,
        this.classId,
        this.reason,
        this.createdAt,
    });

    factory LeaveRequestModel.fromJson(Map<String, dynamic> json) => LeaveRequestModel(
        id: json["id"],
        mssv: json["mssv"],
        studentName: json["studentName"],
        classId: json["classID"],
        reason: json["reason"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "mssv": mssv,
        "classID": classId,
        "reason": reason,
    };
}