import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/add_test_teacher/screen/add_asignment_2.dart';
import 'package:qldtandroid/functions/make_test_student/screen/todo_assignment_view.dart';
import 'package:qldtandroid/functions/to_do_class_student/screen/get_student_assignment_scream.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/test_model.dart';

class TestItemWidget extends StatefulWidget {
  final TestModel testModel;
  const TestItemWidget({super.key, required this.testModel});

  @override
  State<TestItemWidget> createState() => _TestItemWidgetState();
}

class _TestItemWidgetState extends State<TestItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12,),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
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
      ]
          // border: Border(bottom: BorderSide(color: AppColors.gray, width: 0.5)),
          // borderRadius: BorderRadius.circular(20)
          ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.testModel.testName}",
                  style: AppTextStyles.text15W500Black,
                ),
                Text(
                  "Bắt đầu : ${getFormattedDateTime(widget.testModel.startTime)}",
                  style: AppTextStyles.text11W400Gray,
                ),
                Text(
                    "Kết thúc : ${getFormattedDateTime(widget.testModel.endTime)} ",
                    style: AppTextStyles.text11W400Gray),
              ],
            ),
          ),
          localObjectPerson == ObjectPerson.teacher
              ? Positioned(
                  top: 10,
                  bottom: 10,
                  right: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [_updateButton(), _deleteButton()],
                  ))
              : Positioned(
                  top: 20, bottom: 20, right: 10, child: _makeAssignment())
        ],
      ),
    );
  }

  String getFormattedDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ngày ${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ";
  }

  Widget _updateButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAsignmentView2(
                classID: BlocProvider.of<FormTeacherBloc>(context).classID,
                idTest: widget.testModel.idTest,
              ),
            ));
      },
      child: Container(
        height: 20,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppColors.blue),
        child: Text(
          "Chỉnh sửa",
          style: AppTextStyles.text12W500White,
        ),
      ),
    );
  }

  Widget _deleteButton() {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      gradient: Gradients.gradientRed),
                  child: Text(
                    "Bạn chắc chắn muốn xóa ?",
                    style: AppTextStyles.text16BoldWhite,
                  ),
                ),
                Text(
                  widget.testModel.testName,
                  style: AppTextStyles.text15W500Black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 80,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.gray,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "Hủy",
                          style: AppTextStyles.text15W500White,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<FormTeacherBloc>(context)
                            .add(DeleteTestEvent(testModel: widget.testModel));
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: Gradients.gradientRed,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "Xóa",
                          style: AppTextStyles.text15W500White,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      child: Container(
        height: 20,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppColors.gray),
        child: Text(
          "Xóa",
          style: AppTextStyles.text12W500White,
        ),
      ),
    );
  }

  Widget _makeAssignment() {
    if (widget.testModel.statusTest == 1) {
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) => GetStudentAssgnmentScreen(test: widget.testModel,),));
        },
        child: Container(
          height: 20,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.gray, width: 1),
          ),
          child: const Text(
            "Đã Nộp",
            style: AppTextStyles.text12W500Gray,
          ),
        ),
      );
    }
    if (DateTime.now().isAfter(widget.testModel.endTime)) {
      return Container(
        height: 20,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppColors.gray),
        child: const Text(
          "Quá hạn",
          style: AppTextStyles.text12W500White,
        ),
      );
    } else if (DateTime.now().isBefore(widget.testModel.startTime)) {
      return Container(
        height: 20,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: AppColors.gray),
        child: const Text(
          "Chưa mở",
          style: AppTextStyles.text12W500White,
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ToDoAssignmentView(
                  test: widget.testModel,
                ),
              ));
        },
        child: Container(
          height: 20,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: AppColors.blue),
          child: const Text(
            "Làm bài",
            style: AppTextStyles.text12W500White,
          ),
        ),
      );
    }
  }
}
