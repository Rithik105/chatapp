import 'dart:io';

import 'package:chatapp/Models/user_model.dart';
import 'package:chatapp/Widgets/clipper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Widgets/button.dart';
import 'package:chatapp/Widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CompleteRegisterScreen extends StatelessWidget {
  String imageUrl = "";
  UserModel userModel;
  final TextEditingController _fullName = TextEditingController();
  final FocusNode fullName = FocusNode();

  CompleteRegisterScreen({super.key, required this.userModel});

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
                  Text(" Update Profile",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).textScaleFactor * 50,
                      )),
                  GestureDetector(onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 40, 40, 40),
                            title: Text("Upload profile Picture",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          30,
                                )),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    BlocProvider.of<ChatCubit>(context)
                                        .imageUpload(ImageSource.gallery);
                                  },
                                  leading: const Icon(
                                    Icons.photo,
                                    color: Colors.orange,
                                  ),
                                  title: Text("Select From Gallery",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            15,
                                      )),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    BlocProvider.of<ChatCubit>(context)
                                        .imageUpload(ImageSource.camera);
                                  },
                                  leading: const Icon(
                                    Icons.camera,
                                    color: Colors.orange,
                                  ),
                                  title: Text("Take a Photo",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            15,
                                      )),
                                )
                              ],
                            ),
                          );
                        });
                  }, child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatImageUploadedState) {
                        imageUrl = state.imageUrl;
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.1,
                          backgroundImage: FileImage(state.image),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: MediaQuery.of(context).size.height * 0.1,
                          child: Icon(
                            Icons.account_circle,
                            color: const Color.fromARGB(255, 40, 40, 40),
                            size: MediaQuery.of(context).size.height * 0.2,
                          ),
                        );
                      }
                    },
                  )),
                  CustomSmallTextField(
                      icon: Icons.account_circle,
                      focusNode: fullName,
                      controller: _fullName,
                      hint: "Name",
                      obscure: false),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04),
                    child: BlocListener<ChatCubit, ChatState>(
                        listener: (context, state) {
                          if (state is ChatLoginState) {
                            Navigator.pop(context);
                          }
                        },
                        child: CustomButton(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.4,
                          ontap: () {
                            BlocProvider.of<ChatCubit>(context)
                                .complete(imageUrl, _fullName.text, userModel);
                          },
                          child: const Text("Create Account",
                              style: TextStyle(color: Colors.white)),
                        )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
