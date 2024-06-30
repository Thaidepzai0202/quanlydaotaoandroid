part of 'attendance_teacher_bloc.dart';

sealed class AttendanceTeacherEvent {
  const AttendanceTeacherEvent();
}

final class InitListAttendanceEvent extends AttendanceTeacherEvent {
  final String classID;
  const InitListAttendanceEvent({required this.classID});
}

final class UpdateListAttendanceEvent extends AttendanceTeacherEvent {
  final List<AttendanceModel> listAttendance;
  const UpdateListAttendanceEvent({required this.listAttendance});
}

final class GetLockStatusEvent extends AttendanceTeacherEvent{}

final class UpdateLockStatusEvent extends AttendanceTeacherEvent{
  final int statusLock;
  const UpdateLockStatusEvent({required this.statusLock});
}

final class UpdateAttendanceEvent extends AttendanceTeacherEvent{
  final String mssv;
  final String classID;
  const UpdateAttendanceEvent({required this.classID, required this.mssv});
}
