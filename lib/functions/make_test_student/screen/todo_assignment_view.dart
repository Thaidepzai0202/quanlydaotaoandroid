import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/make_test_student/bloc/form_student_bloc.dart';
import 'package:qldtandroid/functions/make_test_student/widget/do_question.dart';
import 'package:qldtandroid/models/answer_model.dart';
import 'package:qldtandroid/models/assignment_model.dart';
import 'package:qldtandroid/models/test_model.dart';
import 'package:qldtandroid/repo/logger.dart';

class ToDoAssignmentView extends StatefulWidget {
  // final String classID;
  final TestModel test;

  const ToDoAssignmentView({super.key, required this.test});

  @override
  State<ToDoAssignmentView> createState() => _ToDoAssignmentViewState();
}

class _ToDoAssignmentViewState extends State<ToDoAssignmentView> {
  late AssignmentModel assignmentModel;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FormStudentBloc>(context)
        .add(GetTestStudentEvent(idTest: widget.test.idTest!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _titleTest(),
        const SizedBox(height: 10,),
        _deadline(),
        const SizedBox(height: 10,),
        Expanded(
            child: _testContent())
      ]),
    );
  }

  Widget _titleTest() {
    return Container(
      height: 80,
      width: double.infinity,
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
            "${widget.test.testName}",
            style: AppTextStyles.text18BoldWhite,
          )
        ],
      ),
    );
  }

  Widget _deadline() {
    return Text(
      "Hạn nộp : ${getFormattedDateTime(widget.test.endTime)}",
      style: AppTextStyles.text12W500Gray,
    );
  }

  String getFormattedDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ";
  }

  void _updateQuestion(int index, AnswerModel answer) {
    assignmentModel.dataAnswersStudent![index] = answer;
    BlocProvider.of<FormStudentBloc>(context)
        .add(UpdateAssignmentEvent(assignment: assignmentModel));
  }

  Widget _testContent() {
    return BlocListener<FormStudentBloc, FormStudentState>(
      listener: (context, state) {
        if (state.status == FormStudentStatus.submitSuccessfully) {
          Navigator.pop(context);
          BlocProvider.of<FormStudentBloc>(context).add(
              InitFormStudentEvent(
                  classID:
                      BlocProvider.of<FormStudentBloc>(context).classID));
        }
      },
      child: BlocBuilder<FormStudentBloc, FormStudentState>(
        builder: (context, state) {
          if (state.status == FormStudentStatus.initial) {
            return Center(child: const CircularProgressIndicator());
          } else if (state.status == FormStudentStatus.getTestSuccess) {
            assignmentModel = state.assignment ?? AssignmentModel();
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.test!.dataQuestions!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    DoQuestionWidget(
                      question: state.test!.dataQuestions![index],
                      index: index,
                      onUpdate: (answerModel) {
                        _updateQuestion(index, answerModel);
                      },
                    ),
                    index >= state.test!.dataQuestions!.length - 1
                        ? _submitButtom()
                        : SizedBox()
                  ],
                );
              },
            );
          }
          return const Center(
            child: Text("ERROR"),
          );
        },
      ),
    );
  }

  Widget _submitButtom() {
    return Positioned(
        top: 20,
        right: 160,
        child: InkWell(
          onTap: () {
            logger.log(assignmentModel.toJson());
            BlocProvider.of<FormStudentBloc>(context)
                .add(SubmitAssignmentEvent());
          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 140,
            decoration: BoxDecoration(
                gradient: Gradients.gradientGreen,
                borderRadius: BorderRadius.circular(25)),
            child: const Text(
              "Nộp Bài",
              style: AppTextStyles.text18NormalWhite,
            ),
          ),
        ));
  }
}
