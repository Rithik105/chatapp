import 'package:chatapp/Screens/register_screen.dart';
import 'package:chatapp/Widgets/clipper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/home_screen/home_screen.dart';
import 'package:chatapp/Widgets/button.dart';
import 'package:chatapp/Widgets/text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final FocusNode email = FocusNode();
  final FocusNode password = FocusNode();
  final FocusNode login = FocusNode();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipPath(
                    clipper: CustomCurve(),
                    child: Container(
                      color: Colors.orange,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  Text(" Welcome",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).textScaleFactor * 60,
                      )),
                  CustomSmallTextField(
                      icon: Icons.account_circle,
                      focusNode: email,
                      nextNode: password,
                      controller: _email,
                      hint: "Email",
                      obscure: false),
                  CustomSmallTextField(
                      isPassword: true,
                      icon: Icons.key,
                      focusNode: password,
                      nextNode: login,
                      controller: _password,
                      hint: "Password",
                      obscure: true),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.52),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      child: const Text(
                        "FORGOT PASSWORD",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                        right: MediaQuery.of(context).size.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterScreen();
                              }));
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.lato(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        BlocConsumer<ChatCubit, ChatState>(
                            listener: (context, state) {
                          if (state is ChatLoginState) {
                            Fluttertoast.showToast(msg: "Login successful");
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          } else if (state is ChatErrorState) {
                            Fluttertoast.showToast(msg: state.error);
                          }
                        }, builder: (context, state) {
                          if (state is ChatLoadingState) {
                            return CustomButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.3,
                                ontap: () {},
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ));
                          } else {
                            return CustomButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.3,
                                ontap: () {
                                  BlocProvider.of<ChatCubit>(context).login(
                                      _email.text.trim(),
                                      _password.text.trim());
                                },
                                child: const Icon(
                                  Icons.trending_flat,
                                  size: 40,
                                ));
                          }
                        }),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
