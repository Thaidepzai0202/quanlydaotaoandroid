import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/add_test_teacher/widget/add_question_widget.dart';
import 'package:qldtandroid/functions/add_test_teacher/widget/date_time_picker.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/models/question_model.dart';
import 'package:qldtandroid/models/test_model.dart';

class AddAsignmentView2 extends StatefulWidget {
  final String classID;
  final String? idTest;
  const AddAsignmentView2({super.key, required this.classID, this.idTest});

  @override
  State<AddAsignmentView2> createState() => _AddAsignmentView2State();
}

class _AddAsignmentView2State extends State<AddAsignmentView2> {
  late TestModel currentTest;
  final TextEditingController _nameTestController = TextEditingController();
  late DateTime _beginDateTime;
  late DateTime _endDateTime;

  @override
  void initState() {
    _beginDateTime = DateTime.now();
    _endDateTime = _beginDateTime.add(const Duration(hours: 1));
    super.initState();
    if (widget.idTest != null) {
      BlocProvider.of<FormTeacherBloc>(context)
          .add(GetTestEvent(idTest: widget.idTest!));
    }
    currentTest = TestModel(
        classId: widget.classID,
        testName: "",
        dataQuestions: [
          Question(
              dataQuestion: "",
              type: 1,
              dataAnswers: [],
              dataCorrectAnswer: [],
              score: 0)
        ],
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)));
  }

  @override
  void dispose() {
    _nameTestController.dispose();
    super.dispose();
  }

  void _deleteQuestion(int index) {
    BlocProvider.of<FormTeacherBloc>(context)
        .add(DeleteQuestionEvent(index: index));
  }

  void _updateQuestion(int index, Question question) {
    currentTest.dataQuestions![index] = question;
    BlocProvider.of<FormTeacherBloc>(context)
        .add(UpdateTestEvent(testModel: currentTest));
  }

  void _updateTest() {
    currentTest.testName = _nameTestController.text;
    currentTest.startTime = _beginDateTime;
    currentTest.endTime = _endDateTime;
    BlocProvider.of<FormTeacherBloc>(context)
        .add(UpdateTestEvent(testModel: currentTest));
  }

  void _addQuestion() {
    currentTest.dataQuestions!.add(Question(
        dataQuestion: "",
        type: 0,
        dataAnswers: [],
        dataCorrectAnswer: [],
        score: 0));
    BlocProvider.of<FormTeacherBloc>(context)
        .add(UpdateTestEvent(testModel: currentTest));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FormTeacherBloc, FormTeacherState>(
        listener: (context, state) {
          if (state.status == FormTeacherStatus.addSuccess) {
            Navigator.pop(context);
          } else if (state.status == FormTeacherStatus.success) {
            currentTest = state.test!;
            _nameTestController.text = currentTest.testName;
            _beginDateTime = currentTest.startTime;
            _endDateTime = currentTest.endTime;
            setState(() {});
          }
        },
        child: Stack(
          children: [
            Column(children: [
              _titleTest(),
              SizedBox(
                height: 10,
              ),
              _dateTime(),
              SizedBox(
                height: 10,
              ),
              Expanded(child: _makeQuestion(context))
            ]),
            _createButtom(),
          ],
        ),
      ),
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
          Expanded(
            child: TextFormField(
              style: AppTextStyles.text18BoldWhite,
              controller: _nameTestController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "My Test",
                  hintStyle: AppTextStyles.text18BoldGray),
              onChanged: (value) => _updateTest(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CupertinoDateTimePickerDemo(
          title: "Begin",
          selectedDateTime: _beginDateTime,
          onUpdate: (p0) {
            setState(() {
              _beginDateTime = p0;
              _updateTest();
            });
          },
        ),
        const SizedBox(
          width: 20,
        ),
        CupertinoDateTimePickerDemo(
          title: "End",
          selectedDateTime: _endDateTime,
          onUpdate: (p0) {
            setState(() {
              _endDateTime = p0;
              _updateTest();
            });
          },
        ),
      ],
    );
  }

  Widget _makeQuestion(BuildContext context) {
    return BlocBuilder<FormTeacherBloc, FormTeacherState>(
      builder: (context, state) {
        if (state.status == FormTeacherStatus.initial) {
          return Center(child: const CircularProgressIndicator());
        } else {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: currentTest.dataQuestions!.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AddQuestionWidget(
                    index: index,
                    question: currentTest.dataQuestions![index],
                    onDelete: () {
                      _deleteQuestion(index);
                      setState(() {});
                    },
                    onUpdate: (updatedQuestion, valuebool) {
                      _updateQuestion(index, updatedQuestion);
                      if (valuebool) {
                        setState(() {});
                      }
                    },
                  ),
                  index >= currentTest.dataQuestions!.length - 1
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: [
                              const Spacer(),
                              InkWell(
                                onTap: () => setState(() {
                                  _addQuestion();
                                }),
                                child: const Row(children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.gray,
                                  ),
                                  Text(
                                    "Thêm câu hỏi",
                                    style: AppTextStyles.text15W500Gray,
                                  )
                                ]),
                              ),
                            ],
                          ),
                      )
                      : const SizedBox()
                ],
              );
            },
          );
        }
      },
    );
  }

  Widget _createButtom() {
    return Positioned(
        bottom: 10,
        right: 150,
        left: 150,
        child: InkWell(
          onTap: () {
            print("json : ${currentTest.toJson()}");
            BlocProvider.of<FormTeacherBloc>(context)
                .add(AddTestEvent(testModel: currentTest));
          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 80,
            decoration: BoxDecoration(
                gradient: Gradients.gradientGreen,
                borderRadius: BorderRadius.circular(25)),
            child: const Text(
              "Tạo",
              style: AppTextStyles.text18NormalWhite,
            ),
          ),
        ));
  }
}
