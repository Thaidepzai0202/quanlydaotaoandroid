part of 'add_student_to_class_bloc.dart';

enum AddStudentToClassStatus {
  initial,
  success,
  failure,
}

final class AddStudentToClassState extends Equatable {
  final AddStudentToClassStatus? status;
  final String? message;
  const AddStudentToClassState({this.message, this.status});

  AddStudentToClassState copyWith(
      {AddStudentToClassStatus? status, String? message}) {
    return AddStudentToClassState(
        message: message ?? this.message, status: status ?? this.status);
  }

  @override
  List<Object> get props => [status ?? AddStudentToClassStatus.initial, message ?? ""];
}
