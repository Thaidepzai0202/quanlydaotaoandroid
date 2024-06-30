import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qldtandroid/core/constants/api_path.dart';
import 'package:qldtandroid/models/study_document_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class StudyRepo {
  Future<List<StudyDocumentModel>> getListLink(
      {required String classID}) async {
    List<StudyDocumentModel> listStudyDocument = [];

    var res = await http.get(Uri.parse("${ApiPath.studyDocument}/$classID"));
    if (res.statusCode == 200) {
      List<dynamic> result = json.decode(utf8.decode(res.bodyBytes));
      listStudyDocument =
          result.map((e) => StudyDocumentModel.fromJson(e)).toList();

      // logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
    return listStudyDocument;
  }

  Future<void> addLink({required String link,required String classID}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "classID": classID,
      "dataLink": link
    };
    final bodyJson = jsonEncode(body);
    var res = await http.post(Uri.parse(ApiPath.studyDocument),headers: headers,body: bodyJson);
    if (res.statusCode == 200) {
      var result = json.decode(utf8.decode(res.bodyBytes));
      logger.log(result);
    } else {
      logger.log(res.statusCode, color: StrColor.red);
    }
  }
}
