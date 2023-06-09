import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RoundedBlurContainer extends StatelessWidget {
  RoundedBlurContainer({
    this.bottom,
    this.right,
    this.left,
    this.top,
    required this.color,
    super.key,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final Color color;

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
      )
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .move(
            duration: 2.seconds,
            begin: Offset(0, 0),
            end: Offset(50, 40),
          )
          .scale(
            begin: Offset(1.5, 1.5),
            end: Offset(2, 2),
          )
          .fade(begin: 0.6, end: 1),
    );
  }
}
