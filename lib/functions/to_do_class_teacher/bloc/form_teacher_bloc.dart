import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/models/question_model.dart';
import 'package:qldtandroid/models/test_model.dart';
import 'package:qldtandroid/repo/form_repo.dart';
import 'package:qldtandroid/repo/logger.dart';

part 'form_teacher_event.dart';
part 'form_teacher_state.dart';

class FormTeacherBloc extends Bloc<FormTeacherEvent, FormTeacherState> {
  List<TestModel>? listTest = [];
  late String classID;
  TestModel currentTest = TestModel(
      classId: "a",
      testName: "a",
      dataQuestions: [
        Question(
            dataQuestion: "",
            type: 0,
            dataAnswers: [],
            dataCorrectAnswer: [],
            score: 0),
      ],
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)));
  FormTeacherBloc() : super(const FormTeacherState()) {
    on<FormTeacherEvent>((event, emit) {});
    on<ShowListFormEvent>(_onShowListTest);
    on<GetTestEvent>(_onGetTest);
    on<AddTestEvent>(_onAddTest);
    on<DeleteTestEvent>(_onDeleteTest);
    on<DeleteQuestionEvent>(_onDeleteQuestion);
    on<UpdateTestEvent>(_onUpdateTest);
    on<AddNewAnswerEvent>(_onAddNewAnswer);
  }

  Future<void> _onShowListTest(
      ShowListFormEvent event, Emitter<FormTeacherState> emit) async {
    try {
      emit(state.copyWith(status: FormTeacherStatus.initial));
      classID = event.classID;
      listTest = await FormRepo().getListTest(classID: event.classID);
      // logger.log("show",color: StrColor.green);

      emit(state.copyWith(
          status: FormTeacherStatus.success, listTest: listTest));
    } catch (e) {
      logger.log('show list test error : $e');
    }
  }

  Future<void> _onGetTest(
      GetTestEvent event, Emitter<FormTeacherState> emit) async {
    try {
      emit(state.copyWith(status: FormTeacherStatus.initial));
      
      currentTest = await FormRepo().getTest(idTest: event.idTest);
      // logger.log("show",color: StrColor.green);

      emit(
          state.copyWith(status: FormTeacherStatus.success, test: currentTest));
      emit(state.copyWith(
        status: FormTeacherStatus.success,
      ));
    } catch (e) {
      logger.log('show  test error : $e');
    }
  }

  Future<void> _onAddTest(
      AddTestEvent event, Emitter<FormTeacherState> emit) async {
    try {
      emit(state.copyWith(status: FormTeacherStatus.initial));
      // logger.log(event.testModel.toJson());
      await FormRepo().addTest(testModel: event.testModel);

      emit(state.copyWith(
        status: FormTeacherStatus.addSuccess,
      ));
      add(ShowListFormEvent(classID: classID));
    } catch (e) {
      logger.log('Add test error : $e');
    }
  }

  Future<void> _onDeleteTest(
      DeleteTestEvent event, Emitter<FormTeacherState> emit) async {
    try {
      logger.log(event.testModel.toJson());
      await FormRepo().deleteTest(testModel: event.testModel);
      add(ShowListFormEvent(classID: classID));

      // emit(state.copyWith(
      //     status: FormTeacherStatus.success, listTest: listTest));
    } catch (e) {
      logger.log('Add test error : $e');
    }
  }
  
  Future<void> _onUpdateTest(
      UpdateTestEvent event, Emitter<FormTeacherState> emit) async {
    try {
      currentTest = event.testModel;

      emit(state.copyWith(
          status: FormTeacherStatus.success, test: currentTest));
    } catch (e) {
      logger.log('Add test error : $e');
    }
  }

  Future<void> _onDeleteQuestion(
      DeleteQuestionEvent event, Emitter<FormTeacherState> emit) async {
    try {
      currentTest.dataQuestions!.removeAt(event.index);
      emit(state.copyWith(
        status: FormTeacherStatus.deleteQuestionsuccess,test: currentTest
      ));

      // emit(state.copyWith(
      //     status: FormTeacherStatus.success, listTest: listTest));
    } catch (e) {
      logger.log('Add test error : $e');
    }
  }
  Future<void> _onAddNewAnswer(
      AddNewAnswerEvent event, Emitter<FormTeacherState> emit) async {
    try {
      currentTest.dataQuestions![event.index].dataAnswers.add("");
      emit(state.copyWith(
        status: FormTeacherStatus.success,test: currentTest
      ));

      // emit(state.copyWith(
      //     status: FormTeacherStatus.success, listTest: listTest));
    } catch (e) {
      logger.log('Add test error : $e');
    }
  }
}
