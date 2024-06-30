part of 'add_class_teacher_bloc.dart';

sealed class AddClassTeacherEvent {}

class ShowSubjectEvent extends AddClassTeacherEvent {}


class AddClassEvent extends AddClassTeacherEvent{
  final ClassRoomModel classRoomModel;

  AddClassEvent({required this.classRoomModel});
}

class ShowClassEvent extends AddClassTeacherEvent{
  final String mscb;

  ShowClassEvent({required this.mscb});
}
