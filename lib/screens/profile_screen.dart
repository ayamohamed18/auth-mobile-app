import 'package:auth_mobile_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:auth_mobile_app/models/user.dart';
import 'package:auth_mobile_app/screens/login_screen.dart';
import 'package:auth_mobile_app/services/api.dart';
import 'package:auth_mobile_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.token,
  });
  final String token;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final APIService apiService = APIService();
  UserModel userData = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) =>
              ProfileCubit(apiService)..getUserProfile(widget.token),
          child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
            if (state is LoadingProfileState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SuccessProfileState) {
              final user = state.userData;

              return ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.20),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    width: 345,
                                    height: MediaQuery.of(context).size.height *
                                        0.50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              state.userData.userName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: HexColor("#2A2B2E"),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Username",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#808194"),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextFormField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: HexColor("#808194")),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              label: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    user.userName.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: HexColor(
                                                            "#2A2B2E")),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .03,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Email",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#808194"),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: HexColor("#808194")),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              label: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    user.email.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: HexColor(
                                                            "#2A2B2E")),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .03,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Gender",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#808194"),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              enabled: false,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: HexColor("#808194")),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              label: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    user.gender.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: HexColor(
                                                            "#2A2B2E")),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .04,
                                          ),
                                          CustomButon(
                                              color: HexColor("#DC3545"),
                                              onTap: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await prefs.clear();
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()),
                                                );
                                              },
                                              text: "Log out"),
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: const FittedBox(
                            fit: BoxFit.fill,
                            child: Image(
                                image: AssetImage("lib/assets/background.png")),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 116,
                              height: 116,
                              margin: const EdgeInsets.symmetric(vertical: 125),
                              padding:
                                  const EdgeInsets.only(top: 132, left: 139),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        state.userData.image.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor("#00000026")
                                          .withOpacity(0.2),
                                      offset: const Offset(0, 4),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(style: BorderStyle.none)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is LoadingProfileState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Error loading profile.'));
            }
          }),
        ));
  }
}
