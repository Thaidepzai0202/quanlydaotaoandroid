import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/models/leave_request_model.dart';
import 'package:qldtandroid/repo/leave_request_repo.dart';
import 'package:qldtandroid/repo/logger.dart';

part 'leave_request_event.dart';
part 'leave_request_state.dart';

class LeaveRequestBloc extends Bloc<LeaveRequestEvent, LeaveRequestState> {
  List<LeaveRequestModel> listLeaveRequest = [];
  late String classID;
  LeaveRequestBloc() : super(const LeaveRequestState()) {
    on<LeaveRequestEvent>((event, emit) {});
    on<InitGetListEvent>(_onGetList);
    on<SendLeaveRequestEvent>(_onSendLeaveRequest);
  }

  Future<void> _onGetList(
      InitGetListEvent event, Emitter<LeaveRequestState> emit) async {
    try {
      emit(state.copyWith(status: LeaveRequestStatus.initial));
      listLeaveRequest = await LeaveRequestRepo().getListLeaveOfStudent(
        classID: event.classID,
      );
      // logger.log("statusLock : ${event.statusLock}");
      classID = event.classID;
      emit(state.copyWith(
          status: LeaveRequestStatus.success,
          listLeaveRequest: listLeaveRequest));
    } catch (e) {
      emit(state.copyWith(status: LeaveRequestStatus.failure));
      logger.log('Get list leave request error : $e');
    }
  }

  Future<void> _onSendLeaveRequest(
      SendLeaveRequestEvent event, Emitter<LeaveRequestState> emit) async {
    try {
      emit(state.copyWith(status: LeaveRequestStatus.initial));
      await LeaveRequestRepo()
          .sendLeaveRequest(classID: classID, reason: event.reason);
      // logger.log("statusLock : ${event.statusLock}");

      emit(state.copyWith(
        status: LeaveRequestStatus.addSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(status: LeaveRequestStatus.failure));
      logger.log('Send list request error : $e');
    }
  }
}
