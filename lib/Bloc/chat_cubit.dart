import 'dart:io';

import 'package:chatapp/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  int code;
  String error;
  ChatErrorState(this.code, {this.error = ""}) {
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
      case 3:
        Fluttertoast.showToast(msg: error);

        break;
      default:
        error = "";
    }
  }
}

class ChatImageUploadedState extends ChatState {
  File image;
  String imageUrl;
  ChatImageUploadedState(this.image, this.imageUrl);
}

class ChatLoginState extends ChatState {
  UserModel user;
  ChatLoginState({required this.user});
}

class ChatLogOutState extends ChatState {}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  UserCredential? credential;

  void checkState() {
    print("hi");
    (FirebaseAuth.instance.currentUser != null)
        ? fetchDatabase(FirebaseAuth.instance.currentUser!.uid)
        : emit(ChatLogOutState());
  }

  void register(String email, String password, String cpassword) async {
    emit(ChatLoadingState());
    if (email.isEmpty && password.isEmpty) {
      emit(ChatErrorState(0));
    } else if (password != cpassword) {
      emit(ChatErrorState(2));
    } else {
      try {
        credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential!.user!.uid)
            .set(UserModel(
                    uid: credential!.user!.uid,
                    email: email,
                    fullname: "",
                    profilePic: "")
                .toMap())
            .then((value) {
          fetchDatabase(credential!.user!.uid);
        });
      } on FirebaseAuthException catch (e) {
        emit(ChatErrorState(3, error: e.code));
      }
    }
  }

  void login(String email, String password) async {
    emit(ChatLoadingState());
    if (email.isEmpty && password.isEmpty) {
      emit(ChatErrorState(0));
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          fetchDatabase(value.user!.uid);
        });
      } on FirebaseAuthException catch (e) {
        emit(ChatErrorState(3, error: e.code));
      }
    }
  }

  void imageUpload(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    File? imageFile;
    String imageUrl = "";
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      try {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref("profilepictures")
            .child(credential!.user!.uid)
            .putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
        emit(ChatImageUploadedState(imageFile, imageUrl));
      } on FirebaseException catch (e) {
        emit(ChatErrorState(3, error: e.code));
      }
    }
  }

  void complete(String imageUrl, String fullname, UserModel user) async {
    user.fullname = fullname;
    user.profilePic = imageUrl;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(user.toMap());
      fetchDatabase(user.email!);
    } on FirebaseException catch (e) {
      emit(ChatErrorState(3, error: e.code));
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

  Future<void> createDatabase(String name, String email) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .set({"name": name});
  }

  Future<void> createTask(String email, String title, String note) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Tasks")
        .add({"title": title, "note": note});
  }

  Future<void> updateTask(
      String email, String title, String note, String id) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Tasks")
        .doc(id)
        .update({"title": title, "note": note});
  }

  Future fetchDatabase(String uid) async {
    try {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      emit(ChatLoginState(
          user: UserModel.fromMap(userData.data() as Map<String, dynamic>)));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    }
  }

  Future<void> deleteTask(String email, String id) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Tasks")
        .doc(id)
        .delete();
  }
}
