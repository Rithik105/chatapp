import 'package:chatapp/Screens/home_screen/home_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';
import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 0, 238, 255),
                foregroundColor: Colors.black),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: const Color.fromARGB(255, 0, 238, 255))),
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null)
            ? HomeScreen(
                email: FirebaseAuth.instance.currentUser!.email!,
              )
            : LoginScreen(),
      ),
    );
  }
}
