import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'package:qldtandroid/models/class_model.dart';
import 'package:qldtandroid/models/subject_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class AddClassRepo {
  Future<List<SubjectModel>> getListSubject() async {
    List<SubjectModel> listSubject = [];

    var res = await http.get(Uri.parse(ApiPath.listSubject));
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      listSubject = result.map((e) => SubjectModel.fromJson(e)).toList();

      // bookModel = BookModel.fromJson(result);
      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return listSubject;
  }
  Future<List<ClassRoomModel>> getListClass(String mscb) async {
    List<ClassRoomModel> listClass = [];

    var res = await http.get(Uri.parse("${ApiPath.addClass}/$mscb"));
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      listClass = result.map((e) => ClassRoomModel.fromJson(e)).toList();

      // bookModel = BookModel.fromJson(result);
      logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return listClass;
  }

  Future<int> addClass(ClassRoomModel classRoomModel) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = classRoomModel.toJson();
    final bodyJson = jsonEncode(body);

    var res = await http.post(Uri.parse(ApiPath.addClass),
        body: bodyJson, headers: headers);
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      logger.log(result);
      return 200;
    } else {
      logger.log(res.statusCode, color: StrColor.red);
      return res.statusCode;
    }
  }
}
