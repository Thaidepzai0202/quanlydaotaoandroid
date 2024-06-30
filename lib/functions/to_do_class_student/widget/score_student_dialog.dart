import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';
import 'package:qldtandroid/functions/update_point_teacher/bloc/class_room_teacher_bloc.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/class_content_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class ScoreStudentDialog extends StatefulWidget {
  const ScoreStudentDialog({super.key});

  @override
  State<ScoreStudentDialog> createState() => _ScoreStudentDialogState();
}

class _ScoreStudentDialogState extends State<ScoreStudentDialog> {
  List<ClassContentModel> listStudent = [];
  ClassContentModel student =
      ClassContentModel(classId: "", mssv: "", midScore: 0, finalScore: 0);

  @override
  void initState() {
    BlocProvider.of<ClassRoomTeacherBloc>(context).add(ShowListStudentEvent(
        classID: BlocProvider.of<FormStudentBloc>(context).classID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 280,
        width: 280,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          // mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 280,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: Gradients.gradientRedtop,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                "Điểm số",
                style: AppTextStyles.text15W500White,
              ),
            ),
            Spacer(),
            _showScore(),
            Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 42,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: Gradients.gradientRed,
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  StringConst.done,
                  style: AppTextStyles.text16W500White,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _showScore() {
    return BlocBuilder<ClassRoomTeacherBloc, ClassRoomTeacherState>(
      builder: (context, state) {
        if (state.status == ClassRoomStatus.success) {
          listStudent = state.listStudent!;
          listStudent.forEach((element) {
            if (element.mssv == authStudent.mssv) {
              student = element;
            }
          });
          // logger.log(student.toJson());
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _scoreItem(title: "Giữa kỳ", score: student.midScore),
                  _scoreItem(title: "Cuối kỳ", score: student.finalScore),
                ],
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _scoreItem({required String title, required double score}) {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(3, 3), // changes position of shadow
            ),
            BoxShadow(
              color: AppColors.gray.withOpacity(0.1),
              spreadRadius: 0.2,
              blurRadius: 2,
              offset: Offset(-1, -1), // changes position of shadow
            ),
          ]),
      child: Column(children: [
        Text(
          title,
          style: AppTextStyles.text15W500Gray,
        ),
        Divider(),
        Expanded(
            child: Center(
                child: Text(
          "$score",
          style: AppTextStyles.text24NormalGray,
        ))),
      ]),
    );
  }
}
