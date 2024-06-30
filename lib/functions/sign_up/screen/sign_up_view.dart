// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qldtandroid/core/constants/image.dart';
import 'package:qldtandroid/core/constants/string_constants.dart';
import 'package:qldtandroid/core/enums/cource.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/core/helps/app_dialogs.dart';
import 'package:qldtandroid/core/models/selectable_Item.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/core/themes/input_decorations.dart';
import 'package:qldtandroid/functions/sign_up/bloc/sign_up_bloc.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/repo/logger.dart';
import 'package:qldtandroid/widgets/notification_dialog.dart';
import 'package:qldtandroid/widgets/pass_word_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController contactLoginTEC = TextEditingController();
  final FocusNode _emailNode = FocusNode(), _passNode = FocusNode();
  TextEditingController passUse = TextEditingController();
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textNumberStudentController =
      TextEditingController();
  final TextEditingController _textClassNameController =
      TextEditingController();
  final TextEditingController _textCourseController = TextEditingController();
  late SelectableItem _gender;
  late SelectableItem _cource;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textGenderController = TextEditingController();
  final TextEditingController _textPass2Controller = TextEditingController();
  ObjectPerson objectPerson = ObjectPerson.student;

  //nhập lại mật khẩu
  final FocusNode _focusRepeatPassword = FocusNode();
  final _rePasswordKey = GlobalKey<FormFieldState>();
  bool isChanging = false;

  @override
  void initState() {
    super.initState();
    _gender = Gender.selectableItemList.first;
    _textGenderController.text = _gender.name;
    _cource = Course.selectableItemList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status == PostStatus.failure) {
            showDialog(
              context: context,
              builder: (context) => NotificationSignUp(message: state.message!),
            );
          } else if (state.status == PostStatus.success) {
            showDialog(
              context: context,
              builder: (context) => NotificationSignUp(message: state.message!),
            );
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(Images.background_hust),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              )),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        // width: 250,
                        height: MediaQuery.of(context).size.height - 40,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              StringConst.createAccount,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white),
                            ),
                            Container(
                              height: 60,
                              width: double.infinity,
                              // color: AppColors.white,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () => setState(() {
                                      objectPerson = ObjectPerson.student;
                                      localObjectPerson = ObjectPerson.student;
                                    }),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          StringConst.student,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: objectPerson ==
                                                      ObjectPerson.student
                                                  ? FontWeight.w500
                                                  : FontWeight.w400,
                                              color: objectPerson ==
                                                      ObjectPerson.student
                                                  ? AppColors.white
                                                  : AppColors.grayHint),
                                        ),
                                        Container(
                                          height: 2,
                                          width: 100,
                                          color:
                                              objectPerson == ObjectPerson.student
                                                  ? AppColors.white
                                                  : AppColors.grayHint,
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => setState(() {
                                      objectPerson = ObjectPerson.teacher;
                                      localObjectPerson = ObjectPerson.teacher;
                                    }),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          StringConst.teacher,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: objectPerson ==
                                                      ObjectPerson.teacher
                                                  ? FontWeight.w500
                                                  : FontWeight.w400,
                                              color: objectPerson ==
                                                      ObjectPerson.teacher
                                                  ? AppColors.white
                                                  : AppColors.grayHint),
                                        ),
                                        Container(
                                          height: 2,
                                          width: 100,
                                          color:
                                              objectPerson == ObjectPerson.teacher
                                                  ? AppColors.white
                                                  : AppColors.grayHint,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              // height: 400,
                              child: Form(
                                key: _formKey,
                                // onChanged: () => _formKey.currentState?.validate(),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      //email -----------------------------
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24,vertical: 10),
                                        child: TextFormField(
                                          controller: contactLoginTEC,
                                          focusNode: _emailNode,
                                          decoration: InputDecorationConst()
                                              .emailForm
                                              .copyWith(
                                                hintText: "Nhập Email",
                                              ),
                                        ),
                                      ),
                                      //họ và tên -----------------------------
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24,vertical: 10),
                                        child: TextFormField(
                                          controller: _textNameController,
                                          // focusNode: _emailNode,
                                          decoration: InputDecorationConst()
                                              .emailForm
                                              .copyWith(
                                                hintText: "Nhập Họ Và tên",
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SvgPicture.asset(
                                                      Images.ic_person_setup,
                                                      color: AppColors.grey666,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      // Mã số sinh viên / cán bộ--------------------
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24,vertical: 10),
                                        child: TextFormField(
                                          controller:
                                              _textNumberStudentController,
                                          // focusNode: _emailNode,
                                          decoration: InputDecorationConst()
                                              .emailForm
                                              .copyWith(
                                                hintText: objectPerson ==
                                                        ObjectPerson.student
                                                    ? StringConst.numberStudent
                                                    : StringConst.numberTeacher,
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SvgPicture.asset(
                                                      Images.ic_person_setup,
                                                      color: AppColors.grey666,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      //Lớp học/ Chức vụ  ------------------------
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24,vertical: 10),
                                        child: TextFormField(
                                          controller: _textClassNameController,
                                          // focusNode: _emailNode,
                                          decoration: InputDecorationConst()
                                              .emailForm
                                              .copyWith(
                                                hintText: objectPerson ==
                                                        ObjectPerson.student
                                                    ? StringConst.className
                                                    : StringConst.position,
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SvgPicture.asset(
                                                      Images.ic_person_setup,
                                                      color: AppColors.grey666,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      //Khóa học----------------------------------
                                      objectPerson == ObjectPerson.student
                                          ? InkWell(
                                              onTap: () =>
                                                  AppDialogs.showListDialog(
                                                          context: context,
                                                          list: Course
                                                              .selectableItemList,
                                                          value: _cource)
                                                      .then((value) {
                                                if (value != null)
                                                  _cource = value;
                                                _textCourseController.text =
                                                    _cource.name;
                                                logger.log(_cource.name);
                                              }),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24,vertical: 10),
                                                child: TextFormField(
                                                  // textCapitalization:
                                                  //     TextCapitalization.words,
                                                  controller:
                                                      _textCourseController,
                                                  // focusNode: _emailNode,
                                                  enabled: false,
                                                  decoration:
                                                      InputDecorationConst()
                                                          .emailForm
                                                          .copyWith(
                                                            hintText: StringConst
                                                                .selectCource,
                                                            prefixIcon: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 10),
                                                                child: SvgPicture
                                                                    .asset(
                                                                  Images
                                                                      .ic_person_setup,
                                                                  color: AppColors
                                                                      .grey666,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 24,vertical: 10),
                                              child: TextFormField(
                                                controller: _textCourseController,
                                                // focusNode: _emailNode,
                                                decoration: InputDecorationConst()
                                                    .emailForm
                                                    .copyWith(
                                                      hintText:
                                                          StringConst.faculty,
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                6.0),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 10),
                                                          child: SvgPicture.asset(
                                                            Images
                                                                .ic_person_setup,
                                                            color:
                                                                AppColors.grey666,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              ),
                                            ),
              
                                      //giới tính-----------------------------
                                      GestureDetector(
                                        onTap: () => AppDialogs.showListDialog(
                                                context: context,
                                                list: Gender.selectableItemList,
                                                value: _gender)
                                            .then((value) {
                                          if (value != null) _gender = value;
                                          _textGenderController.text =
                                              _gender.name;
                                        }),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24,vertical: 10),
                                          child: TextFormField(
                                            controller: _textGenderController,
                                            enabled: false,
                                            // focusNode: _emailNode,
                                            decoration: InputDecorationConst()
                                                .emailForm
                                                .copyWith(
                                                  hintText: "Chọn giới tính",
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(6.0),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: SvgPicture.asset(
                                                        Images.ic_gender,
                                                        color: AppColors.grey666,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                      //Mật khẩu
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0,vertical: 10),
                                        child: PasswordField(
                                          controller: passUse,
                                          hintText: 'Mật khẩu',
                                          focusNode: _passNode,
                                        ),
                                      ),
                                      //Nhập lại mật khẩu
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0,vertical: 10),
                                        child: PasswordField(
                                            key: _rePasswordKey,
                                            focusNode: _focusRepeatPassword,
                                            hintText: "Nhập lại mật khẩu",
                                            controller: _textPass2Controller,
                                            onChanged: (value) {},
                                            // validator: (value) {}
                                            // Validator.reInputPasswordValidator(
                                            //     value, passUse.text, isChanging),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryHust,
                                fixedSize: const Size(371, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SendDataToSignInEvent(
                                        name: _textNameController.text,
                                        mssv: _textNumberStudentController.text,
                                        gender: _textGenderController.text,
                                        email: contactLoginTEC.text,
                                        password: passUse.text,
                                        classNamePosition:
                                            _textClassNameController.text,
                                        courseFaculty: _textCourseController.text,
                                        objectPerson: objectPerson));
                              },
                              child: const Text(
                                StringConst.signUp,
                                style:
                                    TextStyle(fontSize: 17, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  StringConst.doHaveAnAccount,
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
                                      StringConst.login,
                                      style: TextStyle(
                                        color: AppColors.primaryHust,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.primaryHust,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
