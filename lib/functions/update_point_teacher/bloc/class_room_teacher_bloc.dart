import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/models/class_content_model.dart';
import 'package:qldtandroid/repo/class_content_reo.dart';
import 'package:qldtandroid/repo/logger.dart';

part 'class_room_teacher_event.dart';
part 'class_room_teacher_state.dart';

class ClassRoomTeacherBloc
    extends Bloc<ClassRoomTeacherEvent, ClassRoomTeacherState> {
  List<ClassContentModel>? listClassContent;

  ClassRoomTeacherBloc() : super(const ClassRoomTeacherState()) {
    on<ClassRoomTeacherEvent>((event, emit) {});
    on<ShowListStudentEvent>(_onShowListStudent);
    on<UpdatePointForStudentEvent>(_onUpdatePointStudent);
  }

  Future<void> _onShowListStudent(
      ShowListStudentEvent event, Emitter<ClassRoomTeacherState> emit) async {
    try {
      emit(state.copyWith(status: ClassRoomStatus.initial));
      listClassContent = await ClassContentRepo().getListSubject(event.classID);
      emit(state.copyWith(
          status: ClassRoomStatus.success, listStudent: listClassContent));
    } catch (e) {
      logger.log('Send error data show subject : $e');
    }
  }

  Future<void> _onUpdatePointStudent(UpdatePointForStudentEvent event,
      Emitter<ClassRoomTeacherState> emit) async {
    try {
      await ClassContentRepo()
          .updatePointForStudent(classContentModel: event.classContentModel);
    } catch (e) {
      logger.log('Send error data show subject : $e');
    }
  }
}
