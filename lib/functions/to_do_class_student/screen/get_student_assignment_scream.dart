import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';
import 'package:qldtandroid/functions/to_do_class_student/widget/show_assignment_widget.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/test_model.dart';

class GetStudentAssgnmentScreen extends StatefulWidget {
  final TestModel test;
  const GetStudentAssgnmentScreen({super.key, required this.test});

  @override
  State<GetStudentAssgnmentScreen> createState() =>
      _GetStudentAssgnmentScreenState();
}

class _GetStudentAssgnmentScreenState extends State<GetStudentAssgnmentScreen> {
  @override
  void initState() {
    BlocProvider.of<FormStudentBloc>(context)
        .add(GetAssignmentStudentEvent(idTest: widget.test.idTest!));
    super.initState();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _titleTest(),
          const SizedBox(height: 10,),
          _informationAuthur(),
          Expanded(
              child: _testContent())
        ],
      ),
    );
  }

  Widget _titleTest() {
    return Container(
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
              offset: Offset(3, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              )),
          Text(
            "${widget.test.testName} ",
            style: AppTextStyles.text18BoldWhite,
          )
        ],
      ),
    );
  }

  Widget _informationAuthur(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            gradient: Gradients.purpleGradientTheme,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "Điểm",
                style: AppTextStyles.text15W500White,
              ),
            ),
            Divider(
              height: 1,
              color: AppColors.white,
            ),
            BlocBuilder<FormStudentBloc, FormStudentState>(
              builder: (context, state) {
                return Expanded(
                    child: Center(
                        child: Text(
                  "${state.assignment?.totalScore ?? 0}",
                  style: AppTextStyles.text24NormalWhite,
                )));
              },
            ),
          ],
        ),
      ),
        Container(
        height: 80,
        width: 200,
        decoration: BoxDecoration(
            // color: AppColors.red,
            gradient: Gradients.purple2GradientTheme,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              authStudent.name,
              style: AppTextStyles.text15W500White,
            ),
            Text(
              "MSSV : ${authStudent.mssv}",
              style: AppTextStyles.text15W500White,
            ),
          ],
        ),
      ),
      ],
    );
  }

  Widget _testContent() {
    return BlocBuilder<FormStudentBloc, FormStudentState>(
      builder: (context, state) {
        if (state.status == FormStudentStatus.initial) {
          return Center(child: const CircularProgressIndicator());
        } else if (state.status == FormStudentStatus.failure) {
          return const Text("Error");
        } else {
          return ListView.builder(
              itemCount: state.test?.dataQuestions!.length,
              itemBuilder: (context, index) => ShowAssignmentWidget(
                  index: index,
                  question: state.test!.dataQuestions![index],
                  answer: state.assignment!.dataAnswersStudent![index] ));
        }
      },
    );
  }
}
