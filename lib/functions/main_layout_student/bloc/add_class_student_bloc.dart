import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/main.dart';
import 'package:qldtandroid/models/class_model.dart';
import 'package:qldtandroid/repo/logger.dart';
import 'package:qldtandroid/repo/student_repo.dart';

part 'add_class_student_event.dart';
part 'add_class_student_state.dart';

class AddClassStudentBloc
    extends Bloc<AddClassStudentEvent, AddClassStudentState> {
  List<ClassRoomModel> listClass = [];
  List<ClassRoomModel> listRegistedClass = [];
  List<ClassRoomModel> filteredItems = [];

  AddClassStudentBloc() : super(const AddClassStudentState()) {
    on<AddClassStudentEvent>((event, emit) {});
    on<ShowClassEvent>(_onShowClass);
    on<ShowRegistedClassEvent>(_onShowRegistedClass);
    on<SearchClassEvent>(_onSearchClass);
    on<AddClassEvent>(_onRegisterClass);
  }
  Future<void> _onShowClass(
      ShowClassEvent event, Emitter<AddClassStudentState> emit) async {
    try {
      emit(state.copyWith(status: AddClassStudentStatus.initial));
      listClass = await StudentRepo().getListClass(null);
      emit(state.copyWith(
          listClass: listClass, status: AddClassStudentStatus.showSuccess));
    } catch (e) {
      logger.log('show error class : $e');
    }
  }
  Future<void> _onShowRegistedClass(
      ShowRegistedClassEvent event, Emitter<AddClassStudentState> emit) async {
    try {
      emit(state.copyWith(status: AddClassStudentStatus.initial));
      listRegistedClass = await StudentRepo().getListClass(authStudent.mssv);
      emit(state.copyWith(
          listClass: listRegistedClass, status: AddClassStudentStatus.showSuccess));
    } catch (e) {
      logger.log('show error class : $e');
    }
  }

  Future<void> _onRegisterClass(
      AddClassEvent event, Emitter<AddClassStudentState> emit) async {
    try {
      int statusCode = await StudentRepo().registerClass(event.classID);
      logger.log(statusCode);

      if (statusCode == 200) {
        emit(state.copyWith(status: AddClassStudentStatus.addSuccess,message: "Đăng ký lớp thành công"));
      } else if(statusCode == 405) {
        emit(state.copyWith(status: AddClassStudentStatus.studentBusy,message: "Bạn đã có tiết học vào thời điểm này"));
      } else if(statusCode==404) {
        emit(state.copyWith(status: AddClassStudentStatus.existedClass,message: "Bạn đã đăng ký lớp học này rồi"));
      }
      emit(state.copyWith(status: AddClassStudentStatus.showSuccess ));
    } catch (e) {
      logger.log('show error class : $e');
    }
  }

  Future<void> _onSearchClass(
      SearchClassEvent event, Emitter<AddClassStudentState> emit) async {
    try {
      List<ClassRoomModel> dummyList = listClass;
      if (event.query.isNotEmpty) {
        List<ClassRoomModel> dummyListData = [];
        for (var item in dummyList) {
          if (event.isID) {
            if (item.dataSubject!.subjectId
                .toLowerCase()
                .contains(event.query.toLowerCase())) {
              dummyListData.add(item);
            }
          } else {
            if (item.dataSubject!.subjectName
                .toLowerCase()
                .contains(event.query.toLowerCase())) {
              dummyListData.add(item);
            }
          }
        }
        filteredItems = dummyListData;
        emit(state.copyWith(
            status: AddClassStudentStatus.showSuccess,
            listClass: filteredItems));
      } else {
        emit(state.copyWith(
            status: AddClassStudentStatus.showSuccess, listClass: listClass));
      }
    } catch (e) {
      logger.log('show error class : $e');
    }
  }
}
