import 'package:flutter/material.dart';

class CustomSmallTextField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String hint;
  bool obscure;
  FocusNode focusNode;
  FocusNode? nextNode;
  CustomSmallTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.obscure,
      required this.focusNode,
      this.nextNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
          focusNode.unfocus();

          FocusScope.of(context).requestFocus(nextNode);
        },
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(hintText: hint),
        obscureText: obscure);
  }
}

class CustomLargeTextField extends StatelessWidget {
  CustomLargeTextField(
      {super.key,
      required this.fontSize,
      required this.controller,
      required this.hint,
      required this.height});
  TextEditingController controller = TextEditingController();
  String hint;
  double height, fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }
}
