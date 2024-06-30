part of 'sign_up_bloc.dart';

enum PostStatus { initial, success, failure, end, mustBuy }

final class SignUpState extends Equatable {
  final PostStatus status;
  final String? message;
  const SignUpState({this.message, this.status = PostStatus.initial});

  SignUpState copyWith({PostStatus? status, String? message}) {
    return SignUpState(
        status: status ?? PostStatus.initial,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [status, message ?? ''];
}
