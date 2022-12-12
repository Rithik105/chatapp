import 'package:chatapp/Bloc/chat_cubit.dart';
import 'package:chatapp/Screens/home_screen.dart';
import 'package:chatapp/Widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen(
      {super.key, required this.email, this.title, this.note, this.id});
  TextEditingController? title = TextEditingController();
  TextEditingController? note = TextEditingController();
  String email;
  String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomLargeTextField(
              fontSize: MediaQuery.of(context).textScaleFactor * 25,
              height: MediaQuery.of(context).size.height * 0.09,
              controller: title!,
              hint: "Title",
            ),
            Expanded(
                child: CustomLargeTextField(
              fontSize: MediaQuery.of(context).textScaleFactor * 20,
              height: MediaQuery.of(context).size.height * 0.09,
              controller: note!,
              hint: "Note",
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (id == null) {
            BlocProvider.of<ChatCubit>(context)
                .createTask(email, title!.text, note!.text);
          } else {
            BlocProvider.of<ChatCubit>(context)
                .updateTask(email, title!.text, note!.text, id!);
          }
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
