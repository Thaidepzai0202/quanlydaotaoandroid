import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/class_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class StudentRepo {
  Future<List<ClassRoomModel>> getListClass(String? mssv) async {
    List<ClassRoomModel> listClass = [];

    var res = await http.get(Uri.parse(mssv == null
        ? ApiPath.addClass
        : "${ApiPath.addClassContents}/${mssv}"));
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      listClass = result.map((e) => ClassRoomModel.fromJson(e)).toList();

      // bookModel = BookModel.fromJson(result);
      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return listClass;
  }

  Future<int> registerClass(String classID) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {"mssv": authStudent.mssv, "classID": classID};
    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.addClassContents),
        headers: headers, body: bodyJson);

    return res.statusCode;
  }
}
