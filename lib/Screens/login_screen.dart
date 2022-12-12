import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/create_screen.dart';
import 'package:chatapp/Screens/home_screen.dart';

import 'package:chatapp/Widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  FocusNode login = FocusNode();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                    focusNode: email,
                    nextNode: password,
                    controller: _email,
                    hint: "Email",
                    obscure: false),
                CustomTextField(
                    focusNode: password,
                    nextNode: login,
                    controller: _password,
                    hint: "Password",
                    obscure: true),
                BlocListener<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if (state is ChatLoginState) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => ChatCubit()
                                      ..fetchData(state.user.user!.email!),
                                    child: HomeScreen(),
                                  )));
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(context)
                          .login(_email.text, _password.text);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("LOGIN"),
                  ),
                ),
                InkWell(
                  child: const Text(
                    "Create account?",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateScreen();
                    }));
                  },
                )
              ]),
        ),
      ),
    );
  }
}
