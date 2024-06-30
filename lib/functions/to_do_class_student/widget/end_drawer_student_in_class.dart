import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/app_text_style.dart';
import 'package:qldtandroid/functions/leave_request/screen/list_leave_request_screen.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';
import 'package:qldtandroid/functions/to_do_class_student/widget/attendance_button.dart';
import 'package:qldtandroid/functions/to_do_class_student/widget/score_student_dialog.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/functions/update_point_teacher/screen/show_list_student_in_class_screen.dart';

class EndDrawerStudentinClass extends StatefulWidget {
  const EndDrawerStudentinClass({super.key});

  @override
  State<EndDrawerStudentinClass> createState() =>
      _EndDrawerStudentinClassState();
}

class _EndDrawerStudentinClassState extends State<EndDrawerStudentinClass> {
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
            _showScore(),
            const SizedBox(
              height: 10,
            ),
            _checkIn(),
            Spacer(),
            _leaveRequsetButton(),
            SizedBox(
              height: 12,
            )
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
                  classID: BlocProvider.of<FormStudentBloc>(context).classID),
            ));
      },
      child: Text(
        "Thành viên lớp",
        style: AppTextStyles.text15W500Black,
      ),
    );
  }

  Widget _showScore() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => ScoreStudentDialog(),
        );
      },
      child: Text(
        "Xem điểm",
        style: AppTextStyles.text15W500Black,
      ),
    );
  }

  Widget _checkIn() {
    return AttendanceButton();
  }

  Widget _leaveRequsetButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListLeaveRequestScreen(),
            ));
      },
      child: Container(
        width: 120,
        height: 40,
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
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              color: AppColors.gray,
            ),
            Text(
              "Xin nghỉ",
              style: AppTextStyles.text15W500Gray,
            ),
          ],
        ),
      ),
    );
  }
}
