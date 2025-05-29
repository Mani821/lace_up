import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laceup/splash.dart';
import 'package:laceup/widgets/animated_button.dart';
import 'package:laceup/widgets/custom_loading.dart';

class Playground extends StatefulWidget {
  const Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(height: 50,width: 120,
        child: AnimatedButton(onTap: (){}, firstText: 'Yay'),

        ),
      )
    );
  }
}
