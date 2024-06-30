import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/main_layout_student/bloc/add_class_student_bloc.dart';
import 'package:qldtandroid/functions/main_layout_student/screen/schedule_student_screen.dart';
import 'package:qldtandroid/functions/to_do_class_student/screen/to_do_class_student_screen.dart';
import 'package:qldtandroid/models/class_model.dart';

class AppMainLayoutStudent extends StatefulWidget {
  const AppMainLayoutStudent({super.key});

  @override
  State<AppMainLayoutStudent> createState() => _AppMainLayoutStudentState();
}

class _AppMainLayoutStudentState extends State<AppMainLayoutStudent> {
  List<ClassRoomModel> listClass = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<AddClassStudentBloc>(context).add(ShowRegistedClassEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          BlocBuilder<AddClassStudentBloc, AddClassStudentState>(
            builder: (context, state) {
              listClass = state.listClass ?? [];
              if (state.status == AddClassStudentStatus.showSuccess) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: Gradients.gradientRedtop,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gray.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ]
                              // border: Border(
                              //     bottom: BorderSide(
                              //         width: 1, color: AppColors.gray))
                              ),
                          child: const Text(
                            StringConst.listClass,
                            style: AppTextStyles.text16BoldWhite,
                          )),
                      Expanded(
                        child: ListView.builder(
                          itemCount: listClass.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ToDoClassStudentScreen(
                                      classRoomModel: listClass[index],
                                    ),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              AppColors.gray.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(3,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(
                                          width: 0.5, color: AppColors.gray),
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(4),
                                  child: Column(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${index + 1} . ${listClass[index].dataSubject!.subjectName}",
                                          style: AppTextStyles.text15W500Black,
                                        ),
                                        Text(
                                          "Mã học phần : ${listClass[index].subjectId}",
                                          style: AppTextStyles.textgray,
                                        ),
                                        Text(
                                          "Giáo viên đứng lớp : ${listClass[index].dataTeacher!.name}",
                                          style: AppTextStyles.textgray,
                                        ),
                                        Text(
                                          "Email : ${listClass[index].dataTeacher!.email}",
                                          style: AppTextStyles.textgray,
                                        ),
                                        Text(
                                          "Lịch học :  Thứ ${listClass[index].dayOfWeek} - Ca : ${listClass[index].classSession}",
                                          style: AppTextStyles.textgray,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Phòng học : ${listClass[index].className}",
                                              style: AppTextStyles.textgray,
                                            ),
                                            Text(
                                              "SL sinh viên : ${listClass[index].currentStudent}/${listClass[index].maxStudent}",
                                              style: AppTextStyles.textgray,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]),
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          onOffDraw()
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.red,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DrawerHeader(
                child: Image.asset(Images.logo_hust),
                decoration: BoxDecoration(
                  color: AppColors.red,
                ),
              ),
            ),
            // List items for navigation
            ListTile(
              title: Text(
                'Danh sách lớp học',
                style: AppTextStyles.text15W500White,
              ),
              onTap: () {
                _scaffoldKey.currentState?.closeDrawer();
              },
            ),
            ListTile(
              title: Text(
                'Thời khóa biểu',
                style: AppTextStyles.text15W500White,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleStudentScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text('Đăng xuất', style: AppTextStyles.text15W500White),
              onTap: () {
                // Handle settings navigation
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget onOffDraw() {
    return Positioned(
        bottom: 20,
        left: 20,
        child: InkWell(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                // gradient: Gradients.gradientRed,
                border: Border.all(width: 2, color: AppColors.red)),
            child: Icon(
              Icons.list_alt,
              color: AppColors.red,
            ),
          ),
        ));
  }
}
