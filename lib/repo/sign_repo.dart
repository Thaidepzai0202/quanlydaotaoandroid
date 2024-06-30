import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'package:qldtandroid/functions/sign_up/bloc/sign_up_bloc.dart';
import 'package:qldtandroid/models/student_model.dart';
import 'package:qldtandroid/models/teacher_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class SignRepo {
  Future<void> getDetailBokData({required int id}) async {
    // BookModel? bookModel;

    var res = await http.get(Uri.parse('http://localhost:3000/students'));
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      // bookModel = BookModel.fromJson(result);
      logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
  }

  Future<RepoSignUpStatus> signUpStudentAccount(
      {required StudentModel studentModel}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> body = studentModel.toJson();
      final bodyJson = jsonEncode(body);
      var res = await http.post(Uri.parse(ApiPath.signUpStudent),
          headers: headers, body: bodyJson);
      if (res.statusCode == 200) {
        var result = json.decode(utf8.decode(res.bodyBytes));
        logger.log(result);
        return RepoSignUpStatus.success;
      } else if (res.statusCode == 500) {
        return RepoSignUpStatus.alreadyExist;
      } else {
        logger.log(res.statusCode, color: StrColor.red);
        return RepoSignUpStatus.failure;
      }
    } catch (e) {
      logger.log("SignUp Bloc : $e");
      return RepoSignUpStatus.failure;
    }
  }

  Future<RepoSignUpStatus> signUpTeacherAccount(
      {required TeacherModel teacherModel}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> body = teacherModel.toJson();
      final bodyJson = jsonEncode(body);
      var res = await http.post(Uri.parse(ApiPath.signUpTeacher),
          headers: headers, body: bodyJson);
      if (res.statusCode == 200) {
        var result = json.decode(utf8.decode(res.bodyBytes));
        logger.log(result);
        return RepoSignUpStatus.success;
      } else if (res.statusCode == 500) {
        return RepoSignUpStatus.alreadyExist;
      } else {
        logger.log(res.statusCode, color: StrColor.red);
        return RepoSignUpStatus.failure;
      }
    } catch (e) {
      logger.log("SignUp Bloc : $e");
      return RepoSignUpStatus.failure;
    }
  }
}
