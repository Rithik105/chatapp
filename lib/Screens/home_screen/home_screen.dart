import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/create_task_screen.dart';
import 'package:chatapp/Screens/home_screen/chat_screen.dart';
import 'package:chatapp/Screens/home_screen/profile_screen.dart';
import 'package:chatapp/Screens/home_screen/task_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.email});
  final String email;

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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Do you really want to logout?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<ChatCubit>(context).logout();
                                },
                                child: Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text("No"))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.logout)),
          )
        ],
        title: const Text("Home"),
      ),
      body: _selectedIndex == 0
          ? TaskScreen(email: widget.email)
          : _selectedIndex == 2
              ? ProfileScreen()
              : ChatScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateTaskScreen(
              email: widget.email,
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
        selectedItemColor: Color.fromARGB(255, 0, 238, 255),
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
