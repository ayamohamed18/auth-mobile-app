part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final UserModel userData;
  final String token;

  SuccessLoginState(this.token, {required this.userData});
}

class ErrorLoginState extends LoginState {
  final String? message;
  ErrorLoginState(this.message);
}
