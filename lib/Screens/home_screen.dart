import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/create_task_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.email});
  String email;

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
                  BlocProvider.of<ChatCubit>(context).logout();
                },
                icon: const Icon(Icons.logout)),
          )
        ],
        title: const Text("Home"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.email)
            .collection("Tasks")
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 189, 188, 188),
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CreateTaskScreen(
                              id: snapshot.data!.docs[index].id,
                              email: widget.email,
                              title: TextEditingController(
                                  text: snapshot.data!.docs[index]
                                      .data()["title"]),
                              note: TextEditingController(
                                  text: snapshot.data!.docs[index]
                                      .data()["note"]),
                            );
                          }));
                        },
                        title: Text(snapshot.data!.docs[index].data()["title"]),
                        subtitle:
                            Text(snapshot.data!.docs[index].data()["note"]),
                      ),
                    );
                  });
            } else {
              return Container();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
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
