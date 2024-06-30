part of 'add_class_student_bloc.dart';

sealed class AddClassStudentEvent {}

class AddClassEvent extends AddClassStudentEvent {
  final String classID;
  AddClassEvent({required this.classID});
}

class ShowClassEvent extends AddClassStudentEvent {}

class ShowRegistedClassEvent extends AddClassStudentEvent {}

class SearchClassEvent extends AddClassStudentEvent {
  final String query;
  final bool isID;
  SearchClassEvent({required this.query, required this.isID});
}






