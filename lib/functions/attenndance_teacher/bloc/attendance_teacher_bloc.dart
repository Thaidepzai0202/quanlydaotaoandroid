import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/models/attendance_model.dart';
import 'package:qldtandroid/repo/attendance_repo.dart';
import 'package:qldtandroid/repo/logger.dart';
part 'attendance_teacher_event.dart';
part 'attendance_teacher_state.dart';

class AttendanceTeacherBloc
    extends Bloc<AttendanceTeacherEvent, AttendanceTeacherState> {
  List<AttendanceModel> listAttendance = [];
  int statusLock = 0;
  late String classID;

  AttendanceTeacherBloc() : super(const AttendanceTeacherState()) {
    on<AttendanceTeacherEvent>((event, emit) {});
    on<InitListAttendanceEvent>(_onInitListAttend);
    on<UpdateListAttendanceEvent>(_updateListAttend);
    // on<GetLockStatusEvent>(_onGetStatusLock);
    on<UpdateLockStatusEvent>(_onUpdateLock);
    on<UpdateAttendanceEvent>(_onStudenUpdate);
  }

  Future<void> _onInitListAttend(InitListAttendanceEvent event,
      Emitter<AttendanceTeacherState> emit) async {
    try {
      emit(state.copyWith(status: AttendaceStatus.initial));
      listAttendance = await AttendanceRepo().getListAttendace(event.classID);
      classID = event.classID;
      statusLock = await AttendanceRepo().getStatusLock(classID: event.classID);
      emit(state.copyWith(
          status: AttendaceStatus.success,
          listAttendance: listAttendance,
          statusLock: statusLock));
    } catch (e) {
      emit(state.copyWith(status: AttendaceStatus.failure));
      logger.log('Get Attendance error : $e');
    }
  }

  Future<void> _updateListAttend(UpdateListAttendanceEvent event,
      Emitter<AttendanceTeacherState> emit) async {
    try {
      await AttendanceRepo().updateListAttendace(
          listAttendance: event.listAttendance, classID: classID);

      emit(state.copyWith(
          status: AttendaceStatus.updateSuccess,
          listAttendance: listAttendance));
    } catch (e) {
      emit(state.copyWith(status: AttendaceStatus.failure));
      logger.log('Update Attendance error : $e');
    }
  }

  Future<void> _onUpdateLock(
      UpdateLockStatusEvent event, Emitter<AttendanceTeacherState> emit) async {
    try {
      statusLock = await AttendanceRepo()
          .updateLock(classID: classID, statusLock: event.statusLock);
      logger.log("statusLock : ${event.statusLock}");
      emit(state.copyWith(statusLock: statusLock));
    } catch (e) {
      emit(state.copyWith(status: AttendaceStatus.failure));
      logger.log('Update Lock error : $e');
    }
  }

  Future<void> _onStudenUpdate(
      UpdateAttendanceEvent event, Emitter<AttendanceTeacherState> emit) async {
    try {
      int check = await AttendanceRepo()
          .updateStudent(classID: event.classID, mssv: event.mssv);
      logger.log("statusLock : ${check}");
      check == 1
          ? emit(state.copyWith(status: AttendaceStatus.updateSuccess))
          : emit(state.copyWith(status: AttendaceStatus.failure));
      ;
    } catch (e) {
      emit(state.copyWith(status: AttendaceStatus.failure));
      logger.log('Update student error : $e');
    }
  }
}
