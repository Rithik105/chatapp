import 'package:chatapp/Screens/complete_register_screen.dart';
import 'package:chatapp/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/home_screen/home_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';
import 'package:chatapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: MaterialApp(
          // builder: (context, child) {
          //   return MediaQuery(
          //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          //     child: (FirebaseAuth.instance.currentUser != null)
          //         ? HomeScreen(
          //             email: FirebaseAuth.instance.currentUser!.email!,
          //           )
          //         : LoginScreen(),
          //   );
          // },
          theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromARGB(255, 40, 40, 40),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 0, 238, 255),
                  foregroundColor: Colors.black),
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: const Color.fromARGB(255, 0, 238, 255))),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()

          // (FirebaseAuth.instance.currentUser != null)
          //     ? BlocProvider<ChatCubit>(
          //         create: (context) => ChatCubit()
          //           ..fetchDatabase(FirebaseAuth.instance.currentUser!.uid),
          //         child: HomeScreen(),
          //       )
          //     : LoginScreen(),
          ),
    );
  }
}
