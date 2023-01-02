import 'dart:async';

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/home_screen/home_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController.view);

    animationController.forward();

    Future.delayed(const Duration(seconds: 5)).then((value) {
      BlocProvider.of<ChatCubit>(context).checkState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatLoginState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        } else if (state is ChatLogOutState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
        }
      },
      child: Center(
          child: FadeTransition(
              opacity: animation,
              child: Image.asset("assets/images/logo.png"))),
    ));
  }
}
