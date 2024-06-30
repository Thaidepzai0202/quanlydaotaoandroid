part of 'attendance_teacher_bloc.dart';

enum AttendaceStatus {
  initial,
  success,
  updateSuccess,
  failure,
}

final class AttendanceTeacherState extends Equatable {
  final AttendaceStatus? status;
  final List<AttendanceModel>? listAttendance;
  final int? statusLock;
  const AttendanceTeacherState(
      {this.status, this.listAttendance, this.statusLock});

  AttendanceTeacherState copyWith(
      {AttendaceStatus? status,
      List<AttendanceModel>? listAttendance,
      int? statusLock}) {
    return AttendanceTeacherState(
        statusLock: statusLock ?? this.statusLock,
        listAttendance: listAttendance ?? this.listAttendance,
        status: status ?? this.status);
  }

  @override
  List<Object> get props =>
      [status ?? AttendaceStatus.initial, listAttendance ?? [], statusLock ?? 0];
}
