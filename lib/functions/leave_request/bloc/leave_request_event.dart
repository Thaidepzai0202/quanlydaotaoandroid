part of 'leave_request_bloc.dart';

sealed class LeaveRequestEvent {
  const LeaveRequestEvent();
}

final class InitGetListEvent extends LeaveRequestEvent {
  final String classID;

  const InitGetListEvent({required this.classID});
}

final class SendLeaveRequestEvent extends LeaveRequestEvent {
  final String reason;

  const SendLeaveRequestEvent({required this.reason});
}
