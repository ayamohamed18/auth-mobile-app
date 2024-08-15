import 'package:auth_mobile_app/models/user.dart';
import 'package:auth_mobile_app/services/api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit(this._apiService) : super(RegisterCubitInitial()) {}

  UserModel currentUser = UserModel();
  final APIService _apiService;

  Future<void> fetchRegisterData(String? username, String? password,
      String? email, bool rememberMe) async {
    emit(LoadingRegisterState());
    try {
      final bool? isSuccess =
          await _apiService.register(username!, password!, email!);
      if (isSuccess == true) {
        emit(SuccessRegisterState());
      } else if (isSuccess == false) {
        emit(ErrorRegisterState("Registration failed. Please try again."));
      }
    } catch (e) {
      emit(ErrorRegisterState(e.toString()));
      print('Registration error: $e');
    }
  }

  Future<void> _saveUserCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
}
