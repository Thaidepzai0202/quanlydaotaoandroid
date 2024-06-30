import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/update_point_teacher/bloc/class_room_teacher_bloc.dart';
import 'package:qldtandroid/models/class_content_model.dart';

class StudentPointWidget extends StatefulWidget {
  final ClassContentModel student;
  const StudentPointWidget({super.key, required this.student});

  @override
  State<StudentPointWidget> createState() => _StudentPointWidgetState();
}

class _StudentPointWidgetState extends State<StudentPointWidget> {
  final TextEditingController _textMidScore = TextEditingController();
  final TextEditingController _textFinalScore = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(_enterPointForStudent);
    _focusNode2.addListener(_enterPointForStudent);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_enterPointForStudent);
    _focusNode2.removeListener(_enterPointForStudent);
    _textMidScore.dispose();
    _textFinalScore.dispose();
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  _enterPointForStudent() {
    if (!_focusNode.hasFocus) {
      BlocProvider.of<ClassRoomTeacherBloc>(context)
          .add(
              UpdatePointForStudentEvent(
                  classContentModel:
                      ClassContentModel(
                          classId: widget.student.classId,
                          mssv: widget.student.mssv,
                          midScore: _textMidScore.text == ""
                              ? widget.student.midScore
                              : double.parse(_textMidScore.text),
                          finalScore: _textFinalScore.text == ""
                              ? widget.student.finalScore
                              : double.parse(_textFinalScore.text))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(3, 3), // changes position of shadow
            ),
            BoxShadow(
              color: AppColors.gray.withOpacity(0.1),
              spreadRadius: 0.2,
              blurRadius: 2,
              offset: Offset(-1, -1), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.student.dataStudent!.name,
                  style: AppTextStyles.text15W500Black,
                ),
                Text(widget.student.mssv, style: AppTextStyles.text15W500Black),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Giữa kỳ"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: 115,
                height: 30,
                child: TextFormField(
                  focusNode: _focusNode,
                  onFieldSubmitted: (value) {
                    _enterPointForStudent();
                  },
                  controller: _textMidScore,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "${widget.student.midScore}",
                  ),
                ),
              ),
              Text("Cuối kỳ"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: 115,
                height: 30,
                child: TextFormField(
                  focusNode: _focusNode2,
                  onFieldSubmitted: (value) {
                    _enterPointForStudent();
                  },
                  controller: _textFinalScore,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "${widget.student.finalScore}",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
