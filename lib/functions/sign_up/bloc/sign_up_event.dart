part of 'sign_up_bloc.dart';

sealed class SignUpEvent {}

class SendDataToSignInEvent extends SignUpEvent {
  final String name;
  final String mssv;
  final String gender;
  final String email;
  final String password;
  final String classNamePosition;
  final String courseFaculty;
  final ObjectPerson objectPerson;

  SendDataToSignInEvent(
      {required this.name,
      required this.mssv,
      required this.gender,
      required this.email,
      required this.password,
      required this.classNamePosition,
      required this.courseFaculty,
      required this.objectPerson
      });
}
