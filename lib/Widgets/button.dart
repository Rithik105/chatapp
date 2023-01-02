import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.child,
      required this.ontap,
      required this.height,
      required this.width});
  Widget child;
  double height, width;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: const StadiumBorder(),
        ),
        child: child,
      ),
    );
  }
}
