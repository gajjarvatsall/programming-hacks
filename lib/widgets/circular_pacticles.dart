import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class CustomCircularParticle extends StatelessWidget {
  const CustomCircularParticle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularParticle(
      key: UniqueKey(),
      awayRadius: 80,
      numberOfParticles: 40,
      speedOfParticles: 0.9,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      onTapAnimation: false,
      // particleColor: Colors.white.withAlpha(150),
      awayAnimationDuration: const Duration(milliseconds: 600),
      maxParticleSize: 7,
      isRandSize: true,
      isRandomColor: true,
      randColorList: [Colors.white60, Colors.grey.shade200],
      enableHover: true,
      hoverColor: Colors.white,
      hoverRadius: 90,
    );
  }
}
