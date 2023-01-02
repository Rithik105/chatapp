import 'package:chatapp/Screens/complete_register_screen.dart';
import 'package:chatapp/Screens/home_screen/home_screen.dart';
import 'package:chatapp/Widgets/clipper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Widgets/button.dart';
import 'package:chatapp/Widgets/text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();

  final FocusNode email = FocusNode();
  final FocusNode password = FocusNode();
  final FocusNode cpassword = FocusNode();

  RegisterScreen({super.key});

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
                  Text(" Register",
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
                    obscure: false,
                  ),
                  CustomSmallTextField(
                      isPassword: true,
                      focusNode: password,
                      nextNode: cpassword,
                      controller: _password,
                      hint: "Password",
                      obscure: true),
                  CustomSmallTextField(
                      isPassword: true,
                      focusNode: cpassword,
                      controller: _cpassword,
                      hint: "Confirm Password",
                      obscure: true),
                  const SizedBox(),
                  Center(
                    child: BlocConsumer<ChatCubit, ChatState>(
                        listener: (context, state) {
                      if (state is ChatLoginState) {
                        Fluttertoast.showToast(
                            msg: "Account successfully created");
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CompleteRegisterScreen(userModel: state.user);
                        }));
                      }
                    }, builder: (context, state) {
                      if (state is ChatLoadingState) {
                        return CustomButton(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.3,
                            ontap: () {},
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ));
                      } else {
                        return CustomButton(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.35,
                            ontap: () {
                              BlocProvider.of<ChatCubit>(context).register(
                                  _email.text.trim(),
                                  _password.text.trim(),
                                  _cpassword.text.trim());
                            },
                            child: const Text("Create Account"));
                      }
                    }),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
