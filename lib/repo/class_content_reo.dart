import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'dart:convert';

import 'package:qldtandroid/models/class_content_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class ClassContentRepo {
  Future<List<ClassContentModel>> getListSubject(String classID) async {
    List<ClassContentModel> listStudent = [];

    var res = await http.get(Uri.parse("${ApiPath.getListStudent}/$classID"));
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      listStudent = result.map((e) => ClassContentModel.fromJson(e)).toList();

      // bookModel = BookModel.fromJson(result);
      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return listStudent;
  }

  Future<void> updatePointForStudent(
      {required ClassContentModel classContentModel}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "classID": classContentModel.classId,
      "mssv": classContentModel.mssv,
      "midScore": classContentModel.midScore,
      "finalScore": classContentModel.finalScore
    };
    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.updatePointForStudent),
        headers: headers, body: bodyJson);
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
  }

  Future<void> addStudentToClass(
      {required String classID, required String mssv}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "classID": classID,
      "listMSSV": [mssv],
    };
    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.addStudentToClass),
        headers: headers, body: bodyJson);
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
      throw "error";
    }
  }
}
