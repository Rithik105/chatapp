import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String hint;
  bool obscure;
  FocusNode focusNode;
  FocusNode? nextNode;
  CustomTextField(
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
