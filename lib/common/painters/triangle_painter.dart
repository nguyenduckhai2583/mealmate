import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;
  final PaintingStyle paintingStyle;
  final Axis axis;

  TrianglePainter({
    this.color = Colors.black,
    this.paintingStyle = PaintingStyle.fill,
    this.axis = Axis.vertical,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = paintingStyle;

    if (axis == Axis.vertical) {
      canvas.drawPath(getVerticalTrianglePath(size.width, size.height), paint);
    } else {
      canvas.drawPath(getHorizontalTrianglePath(size.width, size.height), paint);
    }

  }

  Path getHorizontalTrianglePath(double x, double y) {
    return Path()..moveTo(x / 2, 0)..lineTo(x, y)..lineTo(0, y)..close();
  }

  Path getVerticalTrianglePath(double x, double y) {
    return Path()..moveTo(x / 5, y / 2)..lineTo(x, 0)..lineTo(x, y)..close();
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.paintingStyle != paintingStyle;
  }
}
