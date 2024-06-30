part of 'form_teacher_bloc.dart';

enum FormTeacherStatus {
  initial,
  addSuccess,
  getTestSuccess,
  success,
  deleteQuestionsuccess,
  failure,
}

final class FormTeacherState extends Equatable {
  final List<TestModel>? listTest;
  final FormTeacherStatus status;
  final String? message;
  final TestModel? test;

  const FormTeacherState(
      {this.listTest,
      this.status = FormTeacherStatus.initial,
      this.message,
      this.test});

  FormTeacherState copyWith(
      {List<TestModel>? listTest,
      FormTeacherStatus? status,
      String? message,
      TestModel? test}) {
    return FormTeacherState(
      listTest: listTest ?? this.listTest,
      status: status ?? this.status,
      message: message ?? this.message,
      test: test ?? this.test,
    );
  }

  @override
  List<Object> get props => [
        listTest ?? [],
        status,
        message ?? "",
        test ??
            TestModel(
                classId: "",
                testName: "",
                startTime: DateTime.now(),
                endTime: DateTime.now())
      ];
}
