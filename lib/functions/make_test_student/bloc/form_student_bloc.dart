import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/answer_model.dart';
import 'package:qldtandroid/models/assignment_model.dart';
import 'package:qldtandroid/models/test_model.dart';
import 'package:qldtandroid/repo/form_repo.dart';
import 'package:qldtandroid/repo/logger.dart';

part 'form_student_event.dart';
part 'form_student_state.dart';

class FormStudentBloc extends Bloc<FormStudentEvent, FormStudentState> {
  List<TestModel>? listTest = [];
  late String classID;
  late TestModel currentTest;
  late AssignmentModel assignment;
  FormStudentBloc() : super(const FormStudentState()) {
    on<FormStudentEvent>((event, emit) {});
    on<InitFormStudentEvent>(_onShowListTest);
    on<GetTestStudentEvent>(_onGettTest);
    on<UpdateAssignmentEvent>(_updateAssigment);
    on<SubmitAssignmentEvent>(_submitAssignment);
    on<GetAssignmentStudentEvent>(_getAssignment);
  }

  Future<void> _onShowListTest(
      InitFormStudentEvent event, Emitter<FormStudentState> emit) async {
    try {
      emit(state.copyWith(status: FormStudentStatus.initial));
      classID = event.classID;
      listTest = await FormRepo().getListTestStudent(classID: event.classID);
      emit(state.copyWith(
          status: FormStudentStatus.getListSuccess, listTest: listTest));
    } catch (e) {
      logger.log('show lis test error : $e');
      emit(state.copyWith(status: FormStudentStatus.failure));
    }
  }

  Future<void> _onGettTest(
      GetTestStudentEvent event, Emitter<FormStudentState> emit) async {
    try {
      emit(state.copyWith(status: FormStudentStatus.initial));
      currentTest = await FormRepo().getTest(idTest: event.idTest);
      assignment = AssignmentModel(
          dataAnswersStudent: currentTest.dataQuestions!
              .map((e) => AnswerModel(
                  idQuestion: e.idQuestion,
                  mssv: authStudent.mssv,
                  dataAnswers: []))
              .toList(),
          idTest: currentTest.idTest,
          mssv: authStudent.mssv);
      emit(state.copyWith(
          status: FormStudentStatus.getTestSuccess,
          test: currentTest,
          assignment: assignment));
    } catch (e) {
      logger.log('show list test error : $e');
      emit(state.copyWith(status: FormStudentStatus.failure));
    }
  }

  Future<void> _updateAssigment(
      UpdateAssignmentEvent event, Emitter<FormStudentState> emit) async {
    try {
      assignment = event.assignment;
      logger.log(assignment.toJson());
      emit(state.copyWith(assignment: assignment));
    } catch (e) {
      logger.log('show list test error : $e');
      emit(state.copyWith(status: FormStudentStatus.failure));
    }
  }

  Future<void> _submitAssignment(
      SubmitAssignmentEvent event, Emitter<FormStudentState> emit) async {
    try {
      await FormRepo().submitTest(assignment: assignment);
      // logger.log(assignment.toJson());
      emit(state.copyWith(status: FormStudentStatus.submitSuccessfully));
    } catch (e) {
      logger.log('show list test error : $e');
      emit(state.copyWith(status: FormStudentStatus.failure));
    }
  }

  Future<void> _getAssignment(
      GetAssignmentStudentEvent event, Emitter<FormStudentState> emit) async {
    try {
      emit(state.copyWith(status: FormStudentStatus.initial));
      currentTest = await FormRepo().getTest(idTest: event.idTest);
      assignment = await FormRepo()
          .getAssignment(idTest: event.idTest, mssv: authStudent.mssv);
      logger.log(assignment.toJson());
      emit(state.copyWith(
          status: FormStudentStatus.success, assignment: assignment,test: currentTest));
    } catch (e) {
      logger.log('show test error : $e');
      emit(state.copyWith(status: FormStudentStatus.failure));
    }
  }
}
