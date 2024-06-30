part of 'add_class_student_bloc.dart';

enum AddClassStudentStatus {
  initial,
  success,
  failure,
  addSuccess,
  showSuccess,
  studentBusy,
  existedClass
}

final class AddClassStudentState extends Equatable {
  final AddClassStudentStatus status;
  final List<ClassRoomModel>? listClass;
  final String? message;

  const AddClassStudentState(
      {this.listClass,
      this.status = AddClassStudentStatus.initial,
      this.message});

  AddClassStudentState copyWith(
      {AddClassStudentStatus? status,
      List<ClassRoomModel>? listClass,
      String? message}) {
    return AddClassStudentState(
        status: status ?? this.status,
        listClass: listClass ?? this.listClass,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [status, listClass ?? [], message ?? ""];
}
