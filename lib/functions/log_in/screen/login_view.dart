import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/input_decorations.dart';
import 'package:qldtandroid/functions/add_class_teacher/screen/show_list_class_screen.dart';
import 'package:qldtandroid/functions/log_in/bloc/log_in_bloc.dart';
import 'package:qldtandroid/functions/main_layout_student/screen/app_main_layout_student_screen.dart';
import 'package:qldtandroid/functions/sign_up/screen/sign_up_view.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/widgets/notification_dialog.dart';
import 'package:qldtandroid/widgets/pass_word_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController contactLoginTEC = TextEditingController();
  final FocusNode _emailNode = FocusNode(), _passNode = FocusNode();
  TextEditingController passUse = TextEditingController();
  ObjectPerson _objectPerson = ObjectPerson.student;

  @override
  void initState() {
    super.initState();
    localObjectPerson = ObjectPerson.teacher;
    BlocProvider.of<LogInBloc>(context).add(SendDataLogInEvent(
        mssv: "000001",
        password: "hhhh1234",
        objectPerson: ObjectPerson.teacher));

    // localObjectPerson = ObjectPerson.teacher;
    // BlocProvider.of<LogInBloc>(context).add(SendDataLogInEvent(
    //     mssv: "000005",
    //     password: "hhhh1234",
    //     objectPerson: ObjectPerson.teacher));

    // localObjectPerson = ObjectPerson.student;
    // BlocProvider.of<LogInBloc>(context).add(SendDataLogInEvent(
    //     mssv: "20194669",
    //     password: "password123",
    //     objectPerson: ObjectPerson.student));

    // localObjectPerson = ObjectPerson.student;
    // BlocProvider.of<LogInBloc>(context).add(SendDataLogInEvent(
    //     mssv: "0000017",
    //     password: "hhhh1234",
    //     objectPerson: ObjectPerson.student));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LogInBloc, LogInState>(
        listener: (context, state) {
          if (state.status == LoginStatus.wrong) {
            showDialog(
              context: context,
              builder: (context) => NotificationSignUp(message: state.message!),
            );
          } else if (state.status == LoginStatus.success) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      localObjectPerson == ObjectPerson.teacher
                          // ? const AppMainLayoutTeacher()
                          ? const ShowListClassTeacher()
                          : const AppMainLayoutStudent(),
                ));
          }
        },
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(Images.background_hust),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            )),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50,),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    width: 250,
                    height: 250,
                    child: Image.asset(
                      Images.logo_hust,
                      height: 200,
                      width: 200,
                    )),
                Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => setState(() {
                          _objectPerson = ObjectPerson.student;
                          localObjectPerson = ObjectPerson.student;
                        }),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringConst.student,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      _objectPerson == ObjectPerson.student
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                  color: _objectPerson == ObjectPerson.student
                                      ? AppColors.white
                                      : AppColors.grayHint),
                            ),
                            Container(
                              height: 2,
                              width: 100,
                              color: _objectPerson == ObjectPerson.student
                                  ? AppColors.white
                                  : AppColors.grayHint,
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          _objectPerson = ObjectPerson.teacher;
                          localObjectPerson = ObjectPerson.teacher;
                        }),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringConst.teacher,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      _objectPerson == ObjectPerson.teacher
                                          ? FontWeight.w500
                                          : FontWeight.w400,
                                  color: _objectPerson == ObjectPerson.teacher
                                      ? AppColors.white
                                      : AppColors.grayHint),
                            ),
                            Container(
                              height: 2,
                              width: 100,
                              color: _objectPerson == ObjectPerson.teacher
                                  ? AppColors.white
                                  : AppColors.grayHint,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // EmailField(
                //   controller: contactLoginTEC,
                //   focusNode: _emailNode,
                // hintText: _objectPerson == ObjectPerson.student
                //     ? StringConst.enterMSSV
                //     : StringConst.enterMSCB,
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: contactLoginTEC,
                    focusNode: _emailNode,
                    decoration: InputDecorationConst().emailForm.copyWith(
                          hintText: _objectPerson == ObjectPerson.student
                              ? StringConst.enterMSSV
                              : StringConst.enterMSCB,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PasswordField(
                    controller: passUse,
                    hintText: 'Mật khẩu',
                    focusNode: _passNode,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<LogInBloc>(context).add(SendDataLogInEvent(
                        mssv: contactLoginTEC.text,
                        password: passUse.text,
                        objectPerson: _objectPerson));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryHust,
                    fixedSize: const Size(371, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    StringConst.login,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      StringConst.doNotHaveAnAccount,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        child: const Text(
                          StringConst.signUp,
                          style: TextStyle(
                            color: AppColors.primaryHust,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryHust,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
