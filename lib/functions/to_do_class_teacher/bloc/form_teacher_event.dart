part of 'form_teacher_bloc.dart';

sealed class FormTeacherEvent {}

class ShowListFormEvent extends FormTeacherEvent {
  final String classID;
  ShowListFormEvent({required this.classID});
}

class GetTestEvent extends FormTeacherEvent {
  final String idTest;
  GetTestEvent({required this.idTest});
}

class AddTestEvent extends FormTeacherEvent{
  final TestModel testModel;
  AddTestEvent({required this.testModel});
}


class DeleteTestEvent extends FormTeacherEvent{
  final TestModel testModel;
  DeleteTestEvent({required this.testModel});
}

class UpdateTestEvent extends FormTeacherEvent{
  final TestModel testModel;
  UpdateTestEvent({required this.testModel});
}

class DeleteQuestionEvent extends FormTeacherEvent{
  final int index;
  DeleteQuestionEvent({required this.index});
}

class AddNewAnswerEvent extends FormTeacherEvent{
  final int index;
  AddNewAnswerEvent({required this.index});
}
