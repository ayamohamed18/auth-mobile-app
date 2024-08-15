part of 'register_cubit.dart';

@immutable
abstract class RegisterCubitState {}

class RegisterCubitInitial extends RegisterCubitState {}
class LoadingRegisterState extends RegisterCubitState {}
class SuccessRegisterState extends RegisterCubitState {

  SuccessRegisterState();
}

class ErrorRegisterState extends RegisterCubitState {
  final String? message;
  ErrorRegisterState(this.message);
}


