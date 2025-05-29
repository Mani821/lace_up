import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../splash.dart';


class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: 3.1,
        child: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
        )
            .animate(onPlay: (p) => p.repeat())
            .moveY(
          duration: 600.ms,
          curve: Curves.easeOutCubic,
          begin: 0,
          end: 20,
        )
            .effect(delay: 300.ms)
            .moveY(begin: 20, end: 0, curve: Curves.easeInCubic),
      ),
    );
  }
}
