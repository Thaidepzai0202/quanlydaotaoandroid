part of 'log_in_bloc.dart';

sealed class LogInEvent {}

class SendDataLogInEvent extends LogInEvent{
  final String mssv;
  final String password;
  final ObjectPerson objectPerson;

  SendDataLogInEvent({required this.mssv, required this.password,required this.objectPerson});

}
