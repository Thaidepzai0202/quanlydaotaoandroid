import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/app_text_style.dart';
import 'package:qldtandroid/functions/add_student_to_class/screen/add_student_to_class_screen.dart';
import 'package:qldtandroid/functions/add_test_teacher/screen/add_asignment_2.dart';
import 'package:qldtandroid/functions/attenndance_teacher/screen/attendance_teacher_screen.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/functions/update_point_teacher/screen/show_list_student_in_class_screen.dart';
import 'package:qldtandroid/functions/update_point_teacher/screen/update_point_screen.dart';

class EndDrawerTeacherInClass extends StatefulWidget {
  const EndDrawerTeacherInClass({super.key});

  @override
  State<EndDrawerTeacherInClass> createState() =>
      _EndDrawerTeacherInClassState();
}

class _EndDrawerTeacherInClassState extends State<EndDrawerTeacherInClass> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: AppColors.white,
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            _logoHust(),
            const SizedBox(
              height: 10,
            ),
            _classMember(),
            const SizedBox(
              height: 10,
            ),
            _addMember(),
            const SizedBox(
              height: 10,
            ),
            _updateScore(),
            const SizedBox(
              height: 10,
            ),
            _checkIn(),
            Spacer(),
            _addTest(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoHust() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Image.asset(Images.logo_hust),
    );
  }

  Widget _classMember() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowListStudentInClassScreen(
                  classID: BlocProvider.of<FormTeacherBloc>(context).classID),
            ));
      },
      child: Text(
        "Thành viên lớp",
        style: AppTextStyles.text15W500Black,
      ),
    );
  }

  Widget _addMember() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddStudentToClassScreen()));
      },
      child: Text(
        "Thêm thành viên",
        style: AppTextStyles.text15W500Black,
      ),
    );
  }

  Widget _updateScore() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdatePointScreen(
                  classID: BlocProvider.of<FormTeacherBloc>(context).classID),
            ));
      },
      child: Text(
        "Nhập điểm",
        style: AppTextStyles.text15W500Black,
      ),
    );
  }

  Widget _addTest() {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddAsignmentView2(
              classID: BlocProvider.of<FormTeacherBloc>(context).classID,
            ),
          )),
      child: Container(
        height: 50,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 2, color: AppColors.gray)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              color: AppColors.gray,
            ),
            Text(
              "Tạo bài tập",
              style: AppTextStyles.text15W500Gray,
            )
          ],
        ),
      ),
    );
  }

  Widget _checkIn() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AttendanceTeacherScreen(),
            ));
      },
      child: Container(
        height: 36,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // color: AppColors.white,
            gradient: Gradients.gradientRed,
            borderRadius: BorderRadius.circular(8),
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
        child: Text(
          "Điểm danh ",
          style: AppTextStyles.text16BoldWhite,
        ),
      ),
    );
  }
}
