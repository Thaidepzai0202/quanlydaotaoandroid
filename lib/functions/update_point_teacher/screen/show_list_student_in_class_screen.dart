import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/update_point_teacher/bloc/class_room_teacher_bloc.dart';

class ShowListStudentInClassScreen extends StatefulWidget {
  final String classID;

  const ShowListStudentInClassScreen({super.key, required this.classID});

  @override
  State<ShowListStudentInClassScreen> createState() =>
      _ShowListStudentInClassScreenState();
}

class _ShowListStudentInClassScreenState
    extends State<ShowListStudentInClassScreen> {
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
                  height: 500,
                  width: 500,
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
                          "Danh sách học sinh trong lớp",
                          style: AppTextStyles.text16BoldWhite,
                        )),
                    Expanded(
                        child: ListView.builder(
                            itemCount: state.listStudent!.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 8),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                AppColors.gray.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(3,
                                                3), // changes position of shadow
                                          ),
                                          BoxShadow(
                                            color:
                                                AppColors.gray.withOpacity(0.1),
                                            spreadRadius: 0.2,
                                            blurRadius: 2,
                                            offset: Offset(-1,
                                                -1), // changes position of shadow
                                          ),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(state.listStudent![index]
                                            .dataStudent!.name),
                                        Text(state.listStudent![index].mssv)
                                      ],
                                    ),
                                  ),
                                )))
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
