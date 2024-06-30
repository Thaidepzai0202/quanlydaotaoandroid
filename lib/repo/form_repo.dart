import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/assignment_model.dart';
import 'package:qldtandroid/models/test_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class FormRepo {
  Future<List<TestModel>> getListTest({required String classID}) async {
    List<TestModel> listTest = [];

    var res = await http.get(Uri.parse("${ApiPath.listTest}/$classID"));
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      listTest = result.map((e) => TestModel.fromJson(e)).toList();

      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return listTest;
  }

  Future<List<TestModel>> getListTestStudent({required String classID}) async {
    List<TestModel> listTest = [];
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "mssv": authStudent.mssv,
      "classID": classID,
    };
    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.listTestStudent),
        headers: headers, body: bodyJson);
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      listTest = result.map((e) => TestModel.fromJson(e)).toList();

      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return listTest;
  }

  Future<void> submitTest({required AssignmentModel assignment}) async {
    
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = assignment.toJson();
    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.submitAssignment),
        headers: headers, body: bodyJson);
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      // listTest = result.map((e) => TestModel.fromJson(e)).toList();

      logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
  }

  Future<AssignmentModel> getAssignment({required String idTest,required String mssv}) async {
    late AssignmentModel assignment;
    var res = await http.get(Uri.parse("${ApiPath.getAssgnment}?idTest=$idTest&mssv=$mssv"),
        );
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      assignment = AssignmentModel.fromJson(result);
      // logger.log(assignment.toJson());
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return assignment;
  }

  Future<TestModel> getTest({required String idTest}) async {
    late TestModel test;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "mscb": localObjectPerson == ObjectPerson.teacher ? authTeacher.mscb : authStudent.mssv,
      "idTest": idTest,
    };

    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.getTest),
        headers: headers, body: bodyJson);
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      test = TestModel.fromJson(result);

      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return test;
  }

  Future<void> addTest({required TestModel testModel}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = testModel.toJson();
    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.listTest),
        headers: headers, body: bodyJson);
    if (res.statusCode == 200) {
      dynamic result = json.decode(utf8.decode(res.bodyBytes));

      logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
  }

  Future<void> deleteTest({required TestModel testModel}) async {
    var res = await http.delete(
      Uri.parse("${ApiPath.listTest}/${testModel.idTest}"),
    );
    // print(testModel.classId);
    if (res.statusCode == 200) {
      // dynamic result = json.decode(utf8.decode(res.bodyBytes));

      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
  }
}
