import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/attenndance_teacher/bloc/attendance_teacher_bloc.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/repo/logger.dart';
import 'package:qldtandroid/widgets/notification_dialog.dart';

class AttendanceButton extends StatefulWidget {
  const AttendanceButton({super.key});

  @override
  State<AttendanceButton> createState() => _AttendanceButtonState();
}

class _AttendanceButtonState extends State<AttendanceButton> {
  int statusLock = 0;

  @override
  void initState() {
    BlocProvider.of<AttendanceTeacherBloc>(context).add(InitListAttendanceEvent(
        classID: BlocProvider.of<FormStudentBloc>(context).classID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceTeacherBloc, AttendanceTeacherState>(
      listener: (context, state) {
        if (state.status == AttendaceStatus.updateSuccess) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) =>
                NotificationSignUp(message: 'Điểm danh thành công'),
          );
        }
      },
      child: BlocBuilder<AttendanceTeacherBloc, AttendanceTeacherState>(
        builder: (context, state) {
          statusLock = state.statusLock ?? 0;
          return InkWell(
            onTap: () {
              if (statusLock == 1) {
                BlocProvider.of<AttendanceTeacherBloc>(context).add(
                    UpdateAttendanceEvent(
                        classID:
                            BlocProvider.of<FormStudentBloc>(context).classID,
                        mssv: authStudent.mssv));
              }
            },
            child: Container(
              height: 36,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // color: AppColors.white,
                  gradient: statusLock == 1
                      ? Gradients.gradientRed
                      : Gradients.offLinearLight,
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
        },
      ),
    );
  }
}
