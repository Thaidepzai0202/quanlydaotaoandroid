import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qldtandroid/core/enums/gender.dart';
import 'package:qldtandroid/models/student_model.dart';
import 'package:qldtandroid/models/teacher_model.dart';
import 'package:qldtandroid/repo/logger.dart';
import 'package:qldtandroid/repo/sign_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

enum RepoSignUpStatus { initial, success, failure, alreadyExist }

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  RepoSignUpStatus _repoSignUpStatus = RepoSignUpStatus.initial;

  SignUpBloc() : super(const SignUpState()) {
    on<SignUpEvent>((event, emit) {});
    on<SendDataToSignInEvent>(_onSendDataSignUp);
  }

  Future<void> _onSendDataSignUp(
      SendDataToSignInEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.initial, message: "Nhập"));
      if (event.mssv != "" &&
          event.classNamePosition != "" &&
          event.courseFaculty != "" &&
          event.email != "" &&
          event.gender != "" &&
          event.name != "" &&
          event.password != "") {
        _repoSignUpStatus = event.objectPerson == ObjectPerson.student
            ? await SignRepo().signUpStudentAccount(
                studentModel: StudentModel(
                    mssv: event.mssv,
                    name: event.name,
                    gender: event.gender,
                    email: event.email,
                    password: event.password,
                    className: event.classNamePosition,
                    course: event.courseFaculty))
            : await SignRepo().signUpTeacherAccount(
                teacherModel: TeacherModel(
                    mscb: event.mssv,
                    name: event.name,
                    gender: event.gender,
                    email: event.email,
                    password: event.password,
                    position: event.classNamePosition,
                    faculty: event.courseFaculty));

        if (_repoSignUpStatus == RepoSignUpStatus.success) {
          emit(state.copyWith(
              status: PostStatus.success,
              message: "Đăng kí tài khoản thành công"));
        } else if (_repoSignUpStatus == RepoSignUpStatus.alreadyExist) {
          emit(state.copyWith(
              status: PostStatus.failure,
              message: "Mã số đã tồn tại vui lòng chọn mã số khác"));
        }
      } else {
        emit(state.copyWith(
            status: PostStatus.failure,
            message: "Vui lòng nhập đầy đủ thông tin"));
      }
    } catch (e) {
      logger.log('Send error data sign up');
    }
  }
}
