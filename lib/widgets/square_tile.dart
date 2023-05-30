import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 100,
      height: 100,
      borderRadius: 20,
      blur: 0,
      alignment: Alignment.bottomCenter,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.2),
          const Color(0xFFFFFFFF).withOpacity(0.2),
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
          const Color(0xFFffffff).withOpacity(0.3),
          const Color((0xFFFFFFFF)).withOpacity(0.05),
        ],
      ),
      border: 0,
      padding: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.white),
      //   borderRadius: BorderRadius.circular(16),
      //   color: Colors.grey[200],
      // ),
      child: Center(
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
