import 'dart:convert';

import 'package:auth_mobile_app/models/user.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String _baseUrl = "https://dummyjson.com/auth";

  Future<Map<String, String>> logIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'token': data['token'],
        'refreshToken': data['refreshToken'],
      };
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool?> register(String username, String password, String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  Future<UserModel> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/user/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    try {
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception("Failed to load profile");
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<String> refreshAuthToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/refresh'),
      body: {
        'refreshToken': refreshToken,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
