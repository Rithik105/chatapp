import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  FocusNode cpassword = FocusNode();
  FocusNode create = FocusNode();

  CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  focusNode: email,
                  nextNode: password,
                  controller: _email,
                  hint: "Email",
                  obscure: false,
                ),
                CustomTextField(
                    focusNode: password,
                    nextNode: cpassword,
                    controller: _password,
                    hint: "Password",
                    obscure: true),
                CustomTextField(
                    focusNode: cpassword,
                    nextNode: create,
                    controller: _cpassword,
                    hint: "Confirm Password",
                    obscure: true),
                BlocListener<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if (state is ChatRegisterState) {
                      Navigator.pop(context);
                    }
                  },
                  child: ElevatedButton(
                    focusNode: create,
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(context).register(
                          _email.text.trim(),
                          _password.text.trim(),
                          _cpassword.text.trim());
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Create Account"),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
