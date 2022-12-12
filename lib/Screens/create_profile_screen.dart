import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Widgets/button.dart';
import 'package:chatapp/Widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProfileScreen extends StatelessWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  final FocusNode name = FocusNode();
  final FocusNode email = FocusNode();
  final FocusNode password = FocusNode();
  final FocusNode cpassword = FocusNode();

  CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          "Register",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSmallTextField(
                    focusNode: name,
                    nextNode: email,
                    controller: _name,
                    hint: "Name",
                    obscure: false),
                CustomSmallTextField(
                  focusNode: email,
                  nextNode: password,
                  controller: _email,
                  hint: "Email",
                  obscure: false,
                ),
                CustomSmallTextField(
                    focusNode: password,
                    nextNode: cpassword,
                    controller: _password,
                    hint: "Password",
                    obscure: true),
                CustomSmallTextField(
                    focusNode: cpassword,
                    controller: _cpassword,
                    hint: "Confirm Password",
                    obscure: true),
                BlocListener<ChatCubit, ChatState>(
                    listener: (context, state) {
                      if (state is ChatRegisterState) {
                        Navigator.pop(context);
                      }
                    },
                    child: CustomButton(
                      ontap: () {
                        BlocProvider.of<ChatCubit>(context).register(
                            _name.text.trim(),
                            _email.text.trim(),
                            _password.text.trim(),
                            _cpassword.text.trim());
                      },
                      child: const Text("Create Account",
                          style: TextStyle(color: Colors.black)),
                    )),
              ]),
        ),
      ),
    );
  }
}
