import 'package:chatapp/Models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/home_screen/create_task_screen.dart';
import 'package:chatapp/Screens/home_screen/chat_screen.dart';
import 'package:chatapp/Screens/home_screen/profile_screen.dart';
import 'package:chatapp/Screens/home_screen/task_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });
  // UserModel? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BlocListener<ChatCubit, ChatState>(
                        listener: (context, state) {
                          if (state is ChatLogOutState) {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          }
                        },
                        child: AlertDialog(
                          title: const Text("Do you really want to logout?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<ChatCubit>(context).logout();
                                },
                                child: const Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text("No"))
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _selectedIndex == 0
          ? TaskScreen(email: "sda")
          : _selectedIndex == 2
              ? const ProfileScreen()
              : const ChatScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateTaskScreen(
              email: 'asd',
              title: TextEditingController(text: ""),
              note: TextEditingController(text: ""),
            );
          }));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user), label: "profile")
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 238, 255),
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
