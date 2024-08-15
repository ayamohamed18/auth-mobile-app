import 'package:auth_mobile_app/models/user.dart';
import 'package:auth_mobile_app/services/api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._apiService) : super(LoginInitial()) {}

  final APIService _apiService;

  bool isLoginPasswordShowing = true;
  IconData suffixIcon = Icons.visibility_outlined;

  changeLoginViabilitySuffixIcon() {
    isLoginPasswordShowing = !isLoginPasswordShowing;
    suffixIcon = isLoginPasswordShowing
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
  }

  Future<void> getLoginData(
      String? username, String? password, bool rememberMe) async {
    emit(LoadingLoginState());
    try {
      final tokens = await _apiService.logIn(username!, password!);
      final token = tokens['token'];
      final refreshToken = tokens['refreshToken'];
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token!);
        await prefs.setString('refreshToken', refreshToken!);
      }

      final user = await _apiService.getProfile(token!);
      emit(SuccessLoginState(userData: user, token));
    } catch (e) {
      print('Login error: $e');
      emit(ErrorLoginState(e.toString()));
    }
  }

  Future<void> refreshTokenAndRetry(String refreshToken) async {
    try {
      final newToken = await _apiService.refreshAuthToken(refreshToken);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', newToken);

      final user = await _apiService.getProfile(newToken);
      emit(SuccessLoginState(userData: user, newToken));
    } catch (e) {
      emit(ErrorLoginState('Token refresh failed: ${e.toString()}'));
    }
  }

  Future<void> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final refreshToken = prefs.getString('refreshToken');

    if (token != null && refreshToken != null) {
      try {
        final user = await _apiService.getProfile(token);
        emit(SuccessLoginState(userData: user, token));
      } catch (e) {
        if (e.toString() == 'Exception: Unauthorized') {
          await refreshTokenAndRetry(refreshToken);
        } else {
          emit(ErrorLoginState(e.toString()));
        }
      }
    } else {
      emit(ErrorLoginState('No tokens found'));
    }
  }
}
