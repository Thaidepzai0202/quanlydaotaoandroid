import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/input_decorations.dart';
import 'package:qldtandroid/functions/add_student_to_class/bloc/add_student_to_class_bloc.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/widgets/notification_dialog.dart';

class AddStudentToClassScreen extends StatefulWidget {
  const AddStudentToClassScreen({super.key});

  @override
  State<AddStudentToClassScreen> createState() =>
      _AddStudentToClassScreenState();
}

class _AddStudentToClassScreenState extends State<AddStudentToClassScreen> {
  TextEditingController _mssvCotroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddStudentToClassBloc, AddStudentToClassState>(
        listener: (context, state) {
          if (state.status == AddStudentToClassStatus.success ||
              state.status == AddStudentToClassStatus.failure) {
            showDialog(
              context: context,
              builder: (context) => NotificationSignUp(message: state.message!),
            );
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
                      "Thêm Thành Viên",
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
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 68),
                    child: Image.asset(Images.logo_hust),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 58.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gray.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                            BoxShadow(
                              color: AppColors.gray.withOpacity(0.1),
                              spreadRadius: 0.2,
                              blurRadius: 2,
                              offset:
                                  Offset(-1, -1), // changes position of shadow
                            ),
                          ]),
                      child: TextFormField(
                          controller: _mssvCotroller,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 32),
                              border: InputBorder.none,
                              hintText: "Nhập MSSV",
                              hintStyle: AppTextStyles.text15W500Gray)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<AddStudentToClassBloc>(context).add(
                            AddEvent(
                                classID:
                                    BlocProvider.of<FormTeacherBloc>(context)
                                        .classID,
                                mssv: _mssvCotroller.text));
                      },
                      child: Container(
                        height: 42,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: Gradients.gradientRed,
                        ),
                        child: Text(
                          "Thêm",
                          style: AppTextStyles.text16BoldWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
