import 'package:flutter/material.dart';

class CustomCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addPolygon([
      const Offset(0, 0),
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      Offset(size.width, 0),
    ], true);
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
