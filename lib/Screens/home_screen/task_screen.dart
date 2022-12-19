// ignore_for_file: must_be_immutable

import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/create_task_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key, required this.email});
  String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tasks",
            style: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 30),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(email)
                  .collection("Tasks")
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(index.toString()),
                            onDismissed: (DismissDirection) {
                              BlocProvider.of<ChatCubit>(context).deleteTask(
                                  email, snapshot.data!.docs[index].id);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.02),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 189, 188, 188),
                                  borderRadius: BorderRadius.circular(50)),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CreateTaskScreen(
                                      id: snapshot.data!.docs[index].id,
                                      email: email,
                                      title: TextEditingController(
                                          text: snapshot.data!.docs[index]
                                              .data()["title"]),
                                      note: TextEditingController(
                                          text: snapshot.data!.docs[index]
                                              .data()["note"]),
                                    );
                                  }));
                                },
                                title: Text(
                                    snapshot.data!.docs[index].data()["title"]),
                                subtitle: Text(
                                    snapshot.data!.docs[index].data()["note"]),
                              ),
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
          ),
        ],
      ),
    );
  }
}
