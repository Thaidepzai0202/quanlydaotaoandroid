part of 'class_room_teacher_bloc.dart';

sealed class ClassRoomTeacherEvent {}

class ShowListStudentEvent extends ClassRoomTeacherEvent {
  final String classID;

  ShowListStudentEvent({required this.classID});
}

class UpdatePointForStudentEvent extends ClassRoomTeacherEvent {
  final ClassContentModel classContentModel;

  UpdatePointForStudentEvent(
      {required this.classContentModel});
}
