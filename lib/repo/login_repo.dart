import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/functions/log_in/bloc/log_in_bloc.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/student_model.dart';
import 'package:qldtandroid/models/teacher_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class LoginRepo {
  Future<RepoLogInStatus> logInStudent(
      {required String mssv,
      required String password,
      required ObjectPerson objectPerson}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> body = objectPerson==ObjectPerson.student ? {"mssv": mssv, "password": password} : {"mscb": mssv, "password": password};
      final bodyJson = jsonEncode(body);
      var res = await http.post(
          Uri.parse(objectPerson == ObjectPerson.student
              ? ApiPath.logInStudent
              : ApiPath.logInTeacher),
          headers: headers,
          body: bodyJson);
      if (res.statusCode == 200) {
        var result = json.decode(utf8.decode(res.bodyBytes));
        if(objectPerson==ObjectPerson.student){
          authStudent = StudentModel.fromJson(result);
        } else{
          authTeacher = TeacherModel.fromJson(result);
        }
        //  objectPerson==ObjectPerson.student ? authStudent = StudentModel.fromJson(result) : authTeacher = TeacherModel.fromJson(result);
        logger.log(result);
        return RepoLogInStatus.success;
      } else if (res.statusCode == 404) {
        return RepoLogInStatus.wrong;
      } else {
        logger.log(res.statusCode, color: StrColor.red);
        return RepoLogInStatus.failure;
      }
    } catch (e) {
      logger.log("Login Bloc : $e");
      return RepoLogInStatus.failure;
    }
  }

  Future<RepoLogInStatus> logInTeacher(
      {required String mssv, required String password}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> body = {"mssv": mssv, "password": password};
      final bodyJson = jsonEncode(body);
      var res = await http.post(Uri.parse(ApiPath.logInStudent),
          headers: headers, body: bodyJson);
      if (res.statusCode == 200) {
        var result = json.decode(utf8.decode(res.bodyBytes));
        logger.log(result);
        return RepoLogInStatus.success;
      } else if (res.statusCode == 404) {
        return RepoLogInStatus.wrong;
      } else {
        logger.log(res.statusCode, color: StrColor.red);
        return RepoLogInStatus.failure;
      }
    } catch (e) {
      logger.log("Login Bloc : $e");
      return RepoLogInStatus.failure;
    }
  }
}
