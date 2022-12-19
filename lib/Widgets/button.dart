import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.child, required this.ontap});
  Widget child;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 0, 238, 255),
        shape: StadiumBorder(),
      ),
      child: child,
    );
  }
}
