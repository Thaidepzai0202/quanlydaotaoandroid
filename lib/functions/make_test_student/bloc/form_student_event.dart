part of 'form_student_bloc.dart';

sealed class FormStudentEvent {}

class InitFormStudentEvent extends FormStudentEvent {
  final String classID;
  InitFormStudentEvent({required this.classID});
}

class GetTestStudentEvent extends FormStudentEvent {
  final String idTest;
  GetTestStudentEvent({required this.idTest});
}

class UpdateAssignmentEvent extends FormStudentEvent {
  final AssignmentModel assignment;
  UpdateAssignmentEvent({required this.assignment});
}

class SubmitAssignmentEvent extends FormStudentEvent {}

class GetAssignmentStudentEvent extends FormStudentEvent {
  final String idTest;
  GetAssignmentStudentEvent({required this.idTest});
}