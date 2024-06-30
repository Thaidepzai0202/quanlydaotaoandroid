part of 'add_class_teacher_bloc.dart';

enum AddClassStatus {
  initial,
  success,
  failure,
  addSuccess,
  classBusy,
  teacherBusy,
  showSuccessClass
}

final class AddClassTeacherState extends Equatable {
  final AddClassStatus status;
  final List<SubjectModel>? listSubject;
  final List<ClassRoomModel>? listClass;

  const AddClassTeacherState(
      {this.listSubject, this.status = AddClassStatus.initial, this.listClass});

  AddClassTeacherState copyWith(
      {AddClassStatus? status,
      List<SubjectModel>? listSubject,
      List<ClassRoomModel>? listClass}) {
    return AddClassTeacherState(
        status: status ?? this.status,
        listClass: listClass ?? this.listClass,
        listSubject: listSubject ?? this.listSubject);
  }

  @override
  List<Object> get props => [status, listSubject ?? [], listClass ?? []];
}
