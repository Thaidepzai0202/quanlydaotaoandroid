import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/add_class_teacher/bloc/add_class_teacher_bloc.dart';
import 'package:qldtandroid/functions/add_class_teacher/widget/main_layout_drawer.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/screen/to_do_class_teacher_screen.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/class_model.dart';

class ShowListClassTeacher extends StatefulWidget {
  const ShowListClassTeacher({super.key});

  @override
  State<ShowListClassTeacher> createState() => _ShowListClassTeacherState();
}

class _ShowListClassTeacherState extends State<ShowListClassTeacher> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ClassRoomModel> filteredItems = [];
  @override
  void initState() {
    BlocProvider.of<AddClassTeacherBloc>(context)
        .add(ShowClassEvent(mscb: authTeacher.mscb));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainLayoutDrawer(),
      key: _scaffoldKey,
      body: Stack(
        children: [
          BlocBuilder<AddClassTeacherBloc, AddClassTeacherState>(
            builder: (context, state) {
              if (state.status == AddClassStatus.showSuccessClass) {
                filteredItems = state.listClass!;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Column(
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
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ]),
                          child: const Text(
                            StringConst.listSubject,
                            style: AppTextStyles.text16BoldWhite,
                          )),

                      // searchWidget(),

                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ToDoClassTeacherScreen(
                                        classRoomModel: filteredItems[index],
                                      ),
                                    ));
                              },
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
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
                                        offset: Offset(-1,
                                            -1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(18),
                                margin: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${index + 1} . ${filteredItems[index].dataSubject!.subjectName} - ${filteredItems[index].subjectId}",
                                      style: AppTextStyles.text15W500Black,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                          "Kỳ học :  ${filteredItems[index].semester}"),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Phòng học : ${filteredItems[index].className}"),
                                        Text(
                                            "Lịch học  : Ca ${filteredItems[index].classSession} - Thứ ${filteredItems[index].dayOfWeek}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          _drawerButton()
        ],
      ),
    );
  }

  Widget _drawerButton() {
    return Positioned(
      bottom: 20,
      left: 20,
      child: InkWell(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
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
