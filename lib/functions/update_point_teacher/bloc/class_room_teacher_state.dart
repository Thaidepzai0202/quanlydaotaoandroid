part of 'class_room_teacher_bloc.dart';

enum ClassRoomStatus {
  initial,
  success,
  failure,
}

final class ClassRoomTeacherState extends Equatable {
  final ClassRoomStatus? status;
  final List<ClassContentModel>? listStudent;

  const ClassRoomTeacherState({this.listStudent, this.status});

  ClassRoomTeacherState copyWith(
      {List<ClassContentModel>? listStudent, ClassRoomStatus? status}) {
    return ClassRoomTeacherState(
        listStudent: listStudent ?? this.listStudent,
        status: status ?? this.status);
  }

  @override
  List<Object> get props =>
      [listStudent ?? [], status ?? ClassRoomStatus.initial];
}
