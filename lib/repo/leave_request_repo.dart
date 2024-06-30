import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/leave_request_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class LeaveRequestRepo {
  Future<List<LeaveRequestModel>> getListLeaveOfStudent(
      {required String classID}) async {
    try {
      List<LeaveRequestModel> listLeaveRequest = [];
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> body = {
        "mssv": authStudent.mssv,
        "classID": classID,
        // "reason": reason
      };
      final bodyJson = jsonEncode(body);

      var res = await http.post(Uri.parse(ApiPath.getListLROfStudent),
          headers: headers, body: bodyJson);
      if (res.statusCode == 200) {
        List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
        listLeaveRequest =
            result.map((e) => LeaveRequestModel.fromJson(e)).toList();
        logger.log(result);
      }
      return listLeaveRequest;
    } catch (e) {
      logger.log("Login Bloc : $e");
    }
    return [];
  }

  Future<void> sendLeaveRequest(
      {required String classID, required String reason}) async {
    try {
      List<LeaveRequestModel> listLeaveRequest = [];
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> body = {
        "mssv": authStudent.mssv,
        "classID": classID,
        "reason": reason
      };
      final bodyJson = jsonEncode(body);

      var res = await http.post(Uri.parse(ApiPath.sendLeaveRequest),
          headers: headers, body: bodyJson);
      if (res.statusCode == 200) {
        List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
        logger.log(result);
      }
    } catch (e) {
      logger.log("Login Bloc : $e");
    }
  }
}
