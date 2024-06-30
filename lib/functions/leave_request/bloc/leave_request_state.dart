part of 'leave_request_bloc.dart';

enum LeaveRequestStatus {
  initial,
  success,
  addSuccess,
  failure,
  wrong,
}

final class LeaveRequestState extends Equatable {
  final LeaveRequestStatus? status;
  final List<LeaveRequestModel>? listLeaveRequest;
  const LeaveRequestState({this.status, this.listLeaveRequest});

  LeaveRequestState copyWith(
      {LeaveRequestStatus? status, List<LeaveRequestModel>? listLeaveRequest}) {
    return LeaveRequestState(
        listLeaveRequest: listLeaveRequest ?? this.listLeaveRequest,
        status: status ?? this.status);
  }

  @override
  List<Object> get props =>
      [status ?? LeaveRequestStatus.initial, listLeaveRequest ?? []];
}
