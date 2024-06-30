import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/main_layout_student/bloc/add_class_student_bloc.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/widget/schedule_item_widget.dart';
import 'package:qldtandroid/models/class_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class ScheduleStudentScreen extends StatefulWidget {
  const ScheduleStudentScreen({super.key});

  @override
  State<ScheduleStudentScreen> createState() => _ScheduleStudentScreenState();
}

class _ScheduleStudentScreenState extends State<ScheduleStudentScreen> {
  List<ClassRoomModel> _listClass = [];
  List<Widget> schedule = [];
  List<Widget> schedule2 = [];
  List<List<ClassRoomModel?>> classRooms =
      List.generate(10, (i) => List.filled(10, null));

  @override
  void initState() {
    _listClass = BlocProvider.of<AddClassStudentBloc>(context).listRegistedClass;
    logger.log(_listClass.map((e) => e.toJson()));
    logger.log("ccc");
    super.initState();
    _listClass.forEach((e) {
      List<int> listSession =
          e.classSession.split(",").map((e0) => int.parse(e0)).toList();
      logger.log(listSession);
      for (var i = 0; i < listSession.length; i++) {
        classRooms[int.parse(e.dayOfWeek)][listSession[i]] = e;
      }
    });
    schedule = classRooms
        .map((e) {
          int ca = 0;
          List<Widget> sessionWidget = e.map((e0) {
            return ScheduleItemWidget(
              index: ca++,
              classRoomModel: e0,
            );
          }).toList();
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sessionWidget.sublist(1, 6));
        })
        .toList()
        .sublist(2, 8);
    for (var i = 0; i < schedule.length; i++) {
      schedule2.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 80,
            height: 32,
            alignment: Alignment.center,
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
              child: Text("Thứ ${i + 2}")),
          schedule[i]
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    "Thời khóa biểu",
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
          Expanded(
              child: Column(
            children: [
              Spacer(),
              _scheduleWidget(),
              Spacer(),
            ],
          ))
        ],
      ),
    );
  }

  Widget _scheduleWidget() {
    return Column(children: schedule2);
  }
}
