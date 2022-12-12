import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatErrorState extends ChatState {
  int code;
  String error = '';
  ChatErrorState(this.code) {
    switch (code) {
      case 0:
        Fluttertoast.showToast(msg: "please enter all the details");
        break;
      case 1:
        Fluttertoast.showToast(msg: "password should be atleast 6 characters");
        break;
      case 2:
        Fluttertoast.showToast(msg: "password do not match");

        break;
      default:
        error = "";
    }
  }
}

class ChatRegisterState extends ChatState {}

class ChatLoginState extends ChatState {
  UserCredential user;
  ChatLoginState({required this.user});
}

class ChatLogOutState extends ChatState {}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  void register(String email, String password, String cpassword) async {
    if (email.isEmpty && password.isEmpty) {
      emit(ChatErrorState(0));
    } else if (password != cpassword) {
      emit(ChatErrorState(2));
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Fluttertoast.showToast(msg: "Account successfully created");
        emit(ChatRegisterState());
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.code);
      }
    }
  }

  void login(String email, String password) async {
    if (email.isEmpty && password.isEmpty) {
      emit(ChatErrorState(0));
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Fluttertoast.showToast(msg: "Login successful");
          emit(ChatLoginState(user: value));
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.code);
      }
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(msg: "Logout successfull");
      emit(ChatLogOutState());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    }
  }

  void fetchData(String email) async {
    try {
      print(email);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(email)
          .get()
          .then((value) {
        print("value =  ${value.get("name")}");
      });
    } catch (e) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(email)
          .set({"name": "rithik"});
    }
  }
}
