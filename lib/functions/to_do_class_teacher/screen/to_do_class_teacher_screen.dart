import 'package:flutter/material.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/widget/end_drawer_teacher_in_class.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/widget/list_form_teacher.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/widget/study_document_view_teacher.dart';
import 'package:qldtandroid/models/class_model.dart';

class ToDoClassTeacherScreen extends StatefulWidget {
  final ClassRoomModel classRoomModel;

  const ToDoClassTeacherScreen({super.key, required this.classRoomModel});

  @override
  State<ToDoClassTeacherScreen> createState() => _ToDoClassTeacherScreenState();
}

class _ToDoClassTeacherScreenState extends State<ToDoClassTeacherScreen> {
  bool isForm = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: EndDrawerTeacherInClass(),
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: Gradients.gradientRedtop,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gray.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                          ]),
                      child: Text(
                        widget.classRoomModel.dataSubject!.subjectName,
                        style: AppTextStyles.text16BoldWhite,
                      )),
                  Positioned(
                      top: 30,
                      left: 20,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: AppColors.white,
                        ),
                      ))
                ],
              ),
              _main()
            ],
          ),
          _drawerButton()
        ],
      ),
    );
  }

  Widget _main() {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => setState(() {
                    isForm = true;
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: isForm ? Gradients.gradientRed : null,
                        border: isForm
                            ? null
                            : Border.all(width: 1, color: AppColors.gray)),
                    child: Text(
                      "Bài tập/Form",
                      style: isForm
                          ? AppTextStyles.text15W500White
                          : AppTextStyles.text15W500Gray,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => setState(() {
                    isForm = false;
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: !isForm ? Gradients.gradientRed : null,
                        border: !isForm
                            ? null
                            : Border.all(width: 1, color: AppColors.gray)),
                    child: Text(
                      "Tài liệu",
                      style: !isForm
                          ? AppTextStyles.text15W500White
                          : AppTextStyles.text15W500Gray,
                    ),
                  ),
                ),
              ),
            ],
          ),
          isForm ? _form() : _documentFile()
        ],
      ),
    );
  }

  Widget _form() {
    return Expanded(
        child: ListFormTeacherWidget(classID: widget.classRoomModel.classId));
  }

  Widget _documentFile() {
    return Expanded(
      child: StudyDocumentViewTeacher(classID: widget.classRoomModel.classId),
    );
  }

  Widget _drawerButton() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: InkWell(
        onTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: AppColors.primaryHust)),
          child: Icon(
            Icons.list_alt,
            color: AppColors.primaryHust,
          ),
        ),
      ),
    );
  }
}
