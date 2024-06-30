import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/attenndance_teacher/bloc/attendance_teacher_bloc.dart';
import 'package:qldtandroid/functions/attenndance_teacher/widget/small_attendance_widget.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/models/attendance_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class AttendanceTeacherScreen extends StatefulWidget {
  const AttendanceTeacherScreen({super.key});

  @override
  State<AttendanceTeacherScreen> createState() =>
      _AttendanceTeacherScreenState();
}

class _AttendanceTeacherScreenState extends State<AttendanceTeacherScreen> {
  late List<AttendanceModel> listAttendance;
  int currentWeek = 0;

  @override
  void initState() {
    BlocProvider.of<AttendanceTeacherBloc>(context).add(InitListAttendanceEvent(
        classID: BlocProvider.of<FormTeacherBloc>(context).classID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AttendanceTeacherBloc, AttendanceTeacherState>(
        listener: (context, state) {
          if (state.status == AttendaceStatus.updateSuccess) {
            Navigator.pop(context);
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: 80,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: Gradients.gradientRedtop,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gray.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: const Text(
                      "Điểm Danh",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      '  Họ vè tên',
                      style: AppTextStyles.text15W500Gray,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "MSSV",
                      style: AppTextStyles.text15W500Gray,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (currentWeek > 0) {
                                  currentWeek--;
                                }
                              });
                            },
                            child: Icon(Icons.arrow_left),
                          ),
                          Text(
                            "Tuần ${currentWeek + 1}",
                            style: AppTextStyles.text15W500Black,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (currentWeek < 14) {
                                  currentWeek++;
                                }
                              });
                            },
                            child: Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<AttendanceTeacherBloc, AttendanceTeacherState>(
                builder: (context, state) {
                  if (state.status == AttendaceStatus.initial) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (state.status == AttendaceStatus.failure) {
                    return const Center(
                      child: Text("ERROR"),
                    );
                  } else if (state.status == AttendaceStatus.success) {
                    listAttendance = state.listAttendance!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listAttendance.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // margin: const EdgeInsets.only(bottom: 10),
                          // padding: const EdgeInsets.symmetric(
                          //   horizontal: 20,
                          // ),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gray.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                                BoxShadow(
                                  color: AppColors.gray.withOpacity(0.1),
                                  spreadRadius: 0.2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      -1, -1), // changes position of shadow
                                ),
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  '  ${index + 1}  ${state.listAttendance![index].name}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "${state.listAttendance![index].mssv}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SmallAttendanceWidget(
                                  dataAttend: state.listAttendance![index]
                                      .dataAttendance![currentWeek],
                                  onChanged: (value) {
                                    listAttendance[index]
                                        .dataAttendance![currentWeek] = value;
                                    setState(() {});
                                    logger.log(
                                        state.listAttendance!.first.toJson());
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            _bottomWidget()
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<AttendanceTeacherBloc, AttendanceTeacherState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  BlocProvider.of<AttendanceTeacherBloc>(context).add(
                      UpdateLockStatusEvent(
                          statusLock: state.statusLock == 0 ? 1 : 0));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                      gradient: state.statusLock == 1
                          ? Gradients.greenGradientTheme
                          : Gradients.offLinearLight,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Điểm danh online",
                    style: AppTextStyles.text13W500White,
                  ),
                ),
              );
            },
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<AttendanceTeacherBloc>(context).add(
                  UpdateListAttendanceEvent(listAttendance: listAttendance));
              // logger.log(listAttendance.map((e) => e.toJson()).toList());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  gradient: Gradients.blueGradientTheme,
                  borderRadius: BorderRadius.circular(8)),
              child: const Text(
                "Lưu",
                style: AppTextStyles.text13W500White,
              ),
            ),
          )
        ],
      ),
    );
  }
}
