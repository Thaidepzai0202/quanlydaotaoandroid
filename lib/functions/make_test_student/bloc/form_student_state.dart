part of 'form_student_bloc.dart';

enum FormStudentStatus {
  initial,
  success,
  getListSuccess,
  getTestSuccess,
  submitSuccessfully,
  failure,
}

final class FormStudentState extends Equatable {
  final List<TestModel>? listTest;
  final FormStudentStatus status;
  final String? message;
  final TestModel? test;
  final AssignmentModel? assignment;
  const FormStudentState(
      {this.listTest,
      this.status = FormStudentStatus.initial,
      this.message,
      this.assignment,
      this.test});

  FormStudentState copyWith(
      {List<TestModel>? listTest,
      FormStudentStatus? status,
      String? message,
      AssignmentModel? assignment,
      TestModel? test}) {
    return FormStudentState(
      listTest: listTest ?? this.listTest,
      status: status ?? this.status,
      message: message ?? this.message,
      test: test ?? this.test,
      assignment: assignment ?? this.assignment
    );
  }

  @override
  List<Object> get props => [
        listTest ?? [],
        status,
        test ??
            TestModel(
                classId: "",
                testName: "",
                startTime: DateTime.now(),
                endTime: DateTime.now()),
        message ?? "",
        assignment ?? AssignmentModel()
      ];
}
