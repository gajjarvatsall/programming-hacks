import 'package:flutter/material.dart';

class RoundedBlurContainer extends StatelessWidget {
  RoundedBlurContainer({
    this.bottom,
    this.right,
    this.left,
    this.top,
    required this.color,
    super.key,
  });

  double? left;
  double? right;
  double? top;
  double? bottom;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
