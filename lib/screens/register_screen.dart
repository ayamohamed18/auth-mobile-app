import 'package:auth_mobile_app/cubit/login_cubit/login_cubit.dart';
import 'package:auth_mobile_app/cubit/register_cubit/register_cubit.dart';
import 'package:auth_mobile_app/screens/login_screen.dart';
import 'package:auth_mobile_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener<RegisterCubit, RegisterCubitState>(
            listener: (context, state) {
              if (state is SuccessRegisterState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration successful!')));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else if (state is ErrorLoginState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Failed to Register"),
                  duration: Duration(milliseconds: 300),
                ));
              }
            },
            child: ListView(
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
                                  height:
                                      MediaQuery.of(context).size.height * .10,
                                ),
                                Expanded(
                                    child: Container(
                                  width: 345,
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
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
                                            'Create new account',
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
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Username",
                                                style: TextStyle(
                                                    color: HexColor("#808194"),
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: _userNameController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: HexColor("#808194")),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            hintStyle: TextStyle(
                                                color: HexColor("#2A2B2E"),
                                                fontSize: 14),
                                            hintText: "ahmed0saber",
                                            suffix: IconButton(
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: HexColor("#808194"),
                                                ),
                                                onPressed: () {
                                                  _userNameController.clear();
                                                  setState(() {});
                                                }),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .03,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Email",
                                                style: TextStyle(
                                                    color: HexColor("#808194"),
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: HexColor("#808194")),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            hintStyle: TextStyle(
                                                color: HexColor("#2A2B2E"),
                                                fontSize: 14),
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: "ahmed0saber33@gmail.com",
                                            suffix: IconButton(
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: HexColor("#808194"),
                                                ),
                                                onPressed: () {
                                                  _emailController.clear();
                                                  setState(() {});
                                                }),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .03,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Password",
                                                style: TextStyle(
                                                    color: HexColor("#808194"),
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          textInputAction: TextInputAction.done,
                                          controller: _passwordController,
                                          obscureText: !passwordVisible,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  passwordVisible =
                                                      !passwordVisible;
                                                });
                                              },
                                              color: HexColor("#808194"),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: HexColor("#808194")),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            hintText: "••••••••",
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Checkbox(
                                                  value: _rememberMe,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _rememberMe =
                                                          value ?? false;
                                                    });
                                                  }),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Remember me",
                                                    style: TextStyle(
                                                      color:
                                                          HexColor("#2A2B2E"),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                child: Text(
                                                  "Have a problem?",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#2A2B2E"),
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          HexColor("#4F90F0"),
                                                      decorationThickness: 1.5,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        CustomButon(
                                            color: HexColor("#007BFF"),
                                            onTap: () async {
                                              String username =
                                                  _userNameController.text;
                                              String password =
                                                  _passwordController.text;
                                              String email =
                                                  _emailController.text;
                                              print("email: $email");
                                              print("username: $username");

                                              context
                                                  .read<RegisterCubit>()
                                                  .fetchRegisterData(
                                                      username,
                                                      password,
                                                      email,
                                                      _rememberMe);
                                              if (username.isEmpty ||
                                                  password.isEmpty ||
                                                  email.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Please complete your data")));
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()),
                                                );
                                              }
                                            },
                                            text: "Register"),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                        ),
                                        Row(
                                          children: [
                                            Text("Already have an account? ",
                                                style: TextStyle(
                                                  color: HexColor("#2A2B2E"),
                                                  fontSize: 14,
                                                )),
                                            InkWell(
                                              child: Text(
                                                "Log in ",
                                                style: TextStyle(
                                                    color: HexColor("#2A2B2E"),
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        HexColor("#4F90F0"),
                                                    decorationThickness: 1.5,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child:
                                                          const LoginScreen(),
                                                      type: PageTransitionType
                                                          .fade),
                                                );
                                              },
                                            )
                                          ],
                                        ),
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
                            padding: const EdgeInsets.only(top: 132, left: 139),
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/inter2grow_logo.png'),
                                  fit: BoxFit.fill,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        HexColor("#00000026").withOpacity(0.2),
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
            )));
  }
}
