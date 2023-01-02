import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomSmallTextField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  String hint;
  bool obscure, isPassword;
  FocusNode focusNode;
  FocusNode? nextNode;
  IconData? icon;
  CustomSmallTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.obscure,
      required this.focusNode,
      this.icon,
      this.isPassword = false,
      this.nextNode});

  @override
  State<CustomSmallTextField> createState() => _CustomSmallTextFieldState();
}

class _CustomSmallTextFieldState extends State<CustomSmallTextField> {
  bool hidden = true;
  @override
  void initState() {
    widget.focusNode.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.025,
          right: MediaQuery.of(context).size.width * 0.025),
      child: TextField(
          style: GoogleFonts.lato(
              color: widget.focusNode.hasFocus ? Colors.orange : Colors.white),
          textInputAction: TextInputAction.next,
          onSubmitted: (value) {
            widget.focusNode.unfocus();

            FocusScope.of(context).requestFocus(widget.nextNode);
          },
          focusNode: widget.focusNode,
          controller: widget.controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.orange),
                  borderRadius: BorderRadius.circular(30)),
              suffixIcon: widget.isPassword
                  ? InkWell(
                      splashColor: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        widget.obscure = !widget.obscure;
                        setState(() {});
                      },
                      child: Icon(
                        widget.obscure ? Icons.key : Icons.key_off,
                        color: widget.focusNode.hasFocus
                            ? Colors.orange
                            : Colors.white,
                      ),
                    )
                  : Icon(
                      widget.icon,
                      color: widget.focusNode.hasFocus
                          ? Colors.orange
                          : Colors.white,
                    ),
              hintText: widget.hint,
              hintStyle: GoogleFonts.lato(
                  color:
                      widget.focusNode.hasFocus ? Colors.orange : Colors.white),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(30))),
          obscureText: widget.obscure),
    );
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
