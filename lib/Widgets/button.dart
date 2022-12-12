import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.child, required this.ontap});
  Widget child;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 0, 238, 255),
          shape: StadiumBorder(),
        ),
        child: child,
      ),
    );
  }
}