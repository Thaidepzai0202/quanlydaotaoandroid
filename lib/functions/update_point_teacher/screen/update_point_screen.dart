import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/update_point_teacher/bloc/class_room_teacher_bloc.dart';
import 'package:qldtandroid/functions/update_point_teacher/widget/student_point_widget.dart';

class UpdatePointScreen extends StatefulWidget {
  final String classID;

  const UpdatePointScreen({super.key, required this.classID});

  @override
  State<UpdatePointScreen> createState() => _UpdatePointScreenState();
}

class _UpdatePointScreenState extends State<UpdatePointScreen> {
  @override
  void initState() {
    BlocProvider.of<ClassRoomTeacherBloc>(context)
        .add(ShowListStudentEvent(classID: widget.classID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClassRoomTeacherBloc, ClassRoomTeacherState>(
        builder: (context, state) {
          if (state.status == ClassRoomStatus.success) {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
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
                                offset:
                                    Offset(3, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: const Text(
                          "Nhập điểm cho sinh viên",
                          style: AppTextStyles.text16BoldWhite,
                        )),
                    Expanded(
                        child: ListView.builder(
                            itemCount: state.listStudent!.length,
                            itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 8),
                                child: StudentPointWidget(
                                  student: state.listStudent![index],
                                ))))
                  ]),
                ),
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
