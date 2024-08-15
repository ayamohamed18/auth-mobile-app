import 'package:auth_mobile_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:auth_mobile_app/cubit/register_cubit/register_cubit.dart';
import 'package:auth_mobile_app/screens/profile_screen.dart';
import 'package:auth_mobile_app/screens/register_screen.dart';
import 'package:auth_mobile_app/services/api.dart';
import 'package:auth_mobile_app/cubit/login_cubit/login_cubit.dart';
import 'package:auth_mobile_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final APIService apiService = APIService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit(apiService)),
        BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(apiService)),
        BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(apiService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<String?>(
            future: _getToken(),
            builder: (context, snapshot) {
              {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return ProfileScreen(token: snapshot.data!);
                } else {
                  return LoginScreen();
                }
              }
            }),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
