part of 'log_in_bloc.dart';

enum LoginStatus {
  initial,
  success,
  failure,
  wrong,
}

final class LogInState extends Equatable {
  final LoginStatus status;
  final String? message;
  const LogInState({this.status = LoginStatus.initial, this.message});

  LogInState copyWith({LoginStatus? status, String? message}) {
    return LogInState(
        status: status ?? this.status,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [status, message ?? ""];
}
