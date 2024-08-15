part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SuccessProfileState extends ProfileState {
  final UserModel userData;

  SuccessProfileState({required this.userData});
}

class ErrorProfileState extends ProfileState {
  final String? message;
  ErrorProfileState(this.message);
}
