import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassMorphismContainer extends StatelessWidget {
  GlassMorphismContainer({
    super.key,
    required this.width,
    required this.height,
    required this.blur,
    this.child,
  });

  double width;
  double height;
  double blur;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: 20,
      blur: blur,
      alignment: Alignment.bottomCenter,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color(0xFFFFFFFF).withOpacity(0.1),
        ],
        stops: const [
          0.1,
          1,
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color((0xFFFFFFFF)).withOpacity(0.01),
        ],
      ),
      border: 3,
      child: child!,
    );
  }
}
