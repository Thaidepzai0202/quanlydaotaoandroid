import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/repo/logger.dart';
import 'package:qldtandroid/repo/login_repo.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

enum RepoLogInStatus { initial, success, failure, wrong }

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  RepoLogInStatus _repoLogInStatus = RepoLogInStatus.initial;
  LogInBloc() : super(const LogInState()) {
    on<LogInEvent>((event, emit) {});
    on<SendDataLogInEvent>(_onSendDataLogIn);
  }

  Future<void> _onSendDataLogIn(
      SendDataLogInEvent event, Emitter<LogInState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.initial, message: "Nhập"));
      if (event.mssv != "" && event.password != "") {
        _repoLogInStatus = await LoginRepo()
            .logInStudent(mssv: event.mssv, password: event.password,objectPerson: event.objectPerson);

        if (_repoLogInStatus == RepoLogInStatus.wrong) {
          emit(state.copyWith(
              status: LoginStatus.wrong,
              message: "Thông tin tài khoản hoặc mật khẩu không chính xác"));
        } else if (_repoLogInStatus == RepoLogInStatus.success) {
          emit(state.copyWith(
              status: LoginStatus.success, message: "Đăng nhập thành công"));
        }
      } else {
        emit(state.copyWith(
            status: LoginStatus.failure,
            message: "Vui lòng nhập đầy đủ thông tin"));
      }
    } catch (e) {
      logger.log('Send error data login');
    }
  }
}
