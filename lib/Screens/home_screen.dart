import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocListener<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatLogOutState) {
                // Navigator.popUntil(context, (route) {route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              }
            },
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<ChatCubit>(context).logout();
                },
                icon: const Icon(Icons.logout)),
          )
        ],
        title: const Text("Home"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
