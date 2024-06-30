import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qldtandroid/core/constants/app_text_style.dart';
import 'package:qldtandroid/core/enums/type_question.dart';
import 'package:qldtandroid/core/themes/app_colors.dart';
import 'package:qldtandroid/functions/to_do_class_teacher/bloc/form_teacher_bloc.dart';
import 'package:qldtandroid/models/question_model.dart';

class AddQuestionWidget extends StatefulWidget {
  final int index;
  final VoidCallback onDelete;
  final Question question;
  final Function(Question, bool) onUpdate;

  const AddQuestionWidget({
    super.key,
    required this.index,
    required this.onDelete,
    required this.question,
    required this.onUpdate,
  });
  @override
  State<AddQuestionWidget> createState() => _AddQuestionWidgetState();
}

class _AddQuestionWidgetState extends State<AddQuestionWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  int _selectedType = 0;
  // int _totalAnswer = 2;
  List<TextEditingController> _listAnswersController = [
    TextEditingController(text: ""),
    TextEditingController(text: "")
  ];
  List<String> _correctAnswer = [];
  final TextEditingController _editingCorrectController =
      TextEditingController(text: "");
  final Map<int, bool> _checkBox = {
    0: false,
    1: false,
  };

  late TextEditingController _scoreController;
  int _selectOne = 0;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.question.type;
    _questionController =
        TextEditingController(text: widget.question.dataQuestion);
    // ignore: unnecessary_null_comparison
    if (widget.question != null) {
      _listAnswersController = widget.question.dataAnswers
          .map((e) => TextEditingController(text: e))
          .toList();
      if (widget.question.type == 2) {
        _editingCorrectController.text =
            widget.question.dataCorrectAnswer.first;
      } else if (widget.question.type == 0) {
        _correctAnswer = widget.question.dataCorrectAnswer;
        // _selectOne = _listAnswersController
        //     .indexOf(TextEditingController(text: _correctAnswer.first));
        //     logger.log("chose one : ${_selectOne}");
        for (var i = 0; i < _listAnswersController.length; i++) {
          if (_listAnswersController[i].text == _correctAnswer.first) {
            _selectOne = i;
            break;
          }
        }
      } else if (widget.question.type == 1) {
        _correctAnswer = widget.question.dataCorrectAnswer;
        for (var i = 0; i < _listAnswersController.length; i++) {
          if (_correctAnswer.contains(_listAnswersController[i].text)) {
            _checkBox[i] = true;
          } else {
            _checkBox[i] = false;
          }
        }
      }
    }
    _scoreController =
        TextEditingController(text: widget.question.score.toString());
  }

  @override
  void dispose() {
    for (var controller in _listAnswersController) {
      controller.dispose();
    }
    _editingCorrectController.dispose();
    _questionController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  void _updateQuestion([bool? needSetState]) {
    widget.onUpdate(
        Question(
          dataQuestion: _questionController.text,
          type: _selectedType,
          dataAnswers: _listAnswersController.map((e) => e.text).toList(),
          dataCorrectAnswer: _selectedType == 2
              ? [_editingCorrectController.text]
              : _correctAnswer,
          score: int.parse(
              _scoreController.text == "" ? "0" : _scoreController.text),
        ),
        needSetState ?? false);
  }

  void _updateCorrectAnswer() {
    List<String> updateCorrect = [];
    if (_selectedType == 0) {
      updateCorrect.add(_listAnswersController[_selectOne].text);
    } else if (_selectedType == 1) {
      for (var element in _listAnswersController) {
        if (_checkBox[_listAnswersController.indexOf(element)] == true) {
          updateCorrect.add(element.text);
        }
      }
    } else if (_selectedType == 2) {
      updateCorrect.add(_editingCorrectController.text);
    }
    _correctAnswer = updateCorrect;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (widget.question != null) {
      _questionController.text = widget.question.dataQuestion;
      _listAnswersController = widget.question.dataAnswers
          .map((e) => TextEditingController(text: e))
          .toList();
      if (widget.question.type == 2) {
        _editingCorrectController.text =
            widget.question.dataCorrectAnswer.first;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${widget.index + 1}. '),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                        hintText: 'Nhập nội dung câu hỏi',
                        border: InputBorder.none),
                    onChanged: (value) => _updateQuestion(),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              width: 220,
              child: DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                value: _selectedType,
                items: QuestionType.selectableItemList.map((item) {
                  return DropdownMenuItem<int>(
                    value: int.parse(item.id),
                    child: Text(
                      item.name,
                      style: AppTextStyles.text15W500Black,
                    ),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
              ),
            ),
            _makeAnswerForQuestion(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Số điểm : ",
                  style: AppTextStyles.text15W500Gray,
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: _scoreController,
                    onChanged: (value) => _updateQuestion(),
                  ),
                ),
                const Spacer(),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.onDelete();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addAnswer() {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0),
      child: InkWell(
        onTap: () {
          // _listAnswersController.add(TextEditingController(text: ""));
          _checkBox[_listAnswersController.length] = false;
          BlocProvider.of<FormTeacherBloc>(context)
              .add(AddNewAnswerEvent(index: widget.index));
          _updateQuestion(true);

          // setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _makeAnswerForQuestion() {
    switch (_selectedType) {
      case 0:
        return _makeOneAnswer();
      case 1:
        return _makeManyAnswer();
      case 2:
        return _makeAnswer();
      case 3:
        return const SizedBox();
      default:
        return _makeOneAnswer();
    }
  }

  Widget _makeOneAnswer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: _listAnswersController
              .map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              _listAnswersController.remove(e);
                            });
                          },
                          child: const Icon(Icons.remove)),
                      Radio(
                          value: _listAnswersController.indexOf(e),
                          groupValue: _selectOne,
                          onChanged: (value) {
                            setState(() {
                              _selectOne = value!;
                              _updateCorrectAnswer();
                              _updateQuestion();
                            });
                          }),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 250,
                        child: TextFormField(
                          controller: e,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Đáp án "),
                          onChanged: (value) {
                            _updateCorrectAnswer();
                            _updateQuestion();
                          },
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
        _addAnswer(),
      ],
    );
  }

  Widget _makeManyAnswer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: _listAnswersController
              .map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              for (var i = _listAnswersController.indexOf(e);
                                  i < _listAnswersController.length - 1;
                                  i++) {
                                _checkBox[i] = _checkBox[i + 1]!;
                              }
                              _checkBox.remove(_listAnswersController.length);
                              _listAnswersController.remove(e);
                              _updateCorrectAnswer();
                              _updateQuestion(true);
                            });
                          },
                          child: const Icon(Icons.remove)),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Checkbox(
                          value: _checkBox[_listAnswersController.indexOf(e)],
                          onChanged: (value) {
                            setState(() {
                              _checkBox[_listAnswersController.indexOf(e)] =
                                  value!;
                              _updateCorrectAnswer();
                              _updateQuestion();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 250,
                        child: TextFormField(
                          controller: e,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Đáp án "),
                          onChanged: (value) {
                            _updateCorrectAnswer();
                            _updateQuestion();
                          },
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
        _addAnswer(),
      ],
    );
  }

  Widget _makeAnswer() {
    return TextFormField(
      controller: _editingCorrectController,
      decoration: const InputDecoration(
        hintText: 'Nhập đáp án',
      ),
      onChanged: (value) => _updateQuestion(),
    );
  }
}
