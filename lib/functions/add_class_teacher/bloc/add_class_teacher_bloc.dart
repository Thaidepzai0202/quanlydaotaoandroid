import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/models/class_model.dart';
import 'package:qldtandroid/models/subject_model.dart';
import 'package:qldtandroid/repo/add_class_repo.dart';
import 'package:qldtandroid/repo/logger.dart';

part 'add_class_teacher_event.dart';
part 'add_class_teacher_state.dart';

class AddClassTeacherBloc
    extends Bloc<AddClassTeacherEvent, AddClassTeacherState> {
  List<SubjectModel> listSubject = [];
  List<ClassRoomModel> listClass = [];

  AddClassTeacherBloc() : super(const AddClassTeacherState()) {
    on<AddClassTeacherEvent>((event, emit) {});
    on<ShowSubjectEvent>(_onShowSubject);
    on<AddClassEvent>(_onAddClass);
    on<ShowClassEvent>(_onShowClass);
  }
  Future<void> _onShowSubject(
      ShowSubjectEvent event, Emitter<AddClassTeacherState> emit) async {
    try {
      emit(state.copyWith(status: AddClassStatus.initial));
      listSubject = await AddClassRepo().getListSubject();
      logger.log(listSubject[0].subjectName.toString());
      emit(state.copyWith(
          status: AddClassStatus.success, listSubject: listSubject));
    } catch (e) {
      logger.log('Send error data show subject : $e');
    }
  }

  Future<void> _onAddClass(
      AddClassEvent event, Emitter<AddClassTeacherState> emit) async {
    try {
      emit(state.copyWith(status: AddClassStatus.initial));
      int check = await AddClassRepo().addClass(event.classRoomModel);
      if (check == 200) {
        emit(state.copyWith(
            status: AddClassStatus.addSuccess, listSubject: listSubject));
      } else if (check == 404) {
        emit(state.copyWith(
          status: AddClassStatus.classBusy,
        ));
      } else if (check == 405) {
        emit(state.copyWith(
          status: AddClassStatus.teacherBusy,
        ));
      } else {
        emit(state.copyWith(
          status: AddClassStatus.failure,
        ));
      }
    } catch (e) {
      logger.log('add error class : $e');
    }
  }

  Future<void> _onShowClass(
      ShowClassEvent event, Emitter<AddClassTeacherState> emit) async {
    try {
      emit(state.copyWith(status: AddClassStatus.initial));
      listClass = await AddClassRepo().getListClass(event.mscb);
      emit(state.copyWith(
          listClass: listClass, status: AddClassStatus.showSuccessClass));
    } catch (e) {
      logger.log('show error class : $e');
    }
  }
}
