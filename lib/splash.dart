import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _navigate() {
    Future.delayed(const Duration(milliseconds: 3200), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder:
              (context, animation, secondaryAnimation) => const Homepage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lace',
                  style: GoogleFonts.playpenSans(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Hero(
                  tag: 'splash',
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: secondaryColor,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                              'assets/arrow.png',
                              color: Colors.white,
                              height: 50,
                            )
                            .animate()
                            .moveY(
                              begin: 60,
                              end: 00,
                              delay: 500.ms,
                              curve: Curves.easeOutBack,
                              duration: 600.ms,
                            )
                            .animate(delay: 800.ms)
                            .moveY(
                              begin: 0,
                              end: -80,
                              delay: 800.ms,
                              curve: Curves.easeInBack,
                              duration: 600.ms,
                            ),
                        Text(
                          "Up",
                          style: GoogleFonts.akayaKanadaka(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate().moveY(
                          begin: 80,
                          end: -2,
                          delay: 2000.ms,
                          curve: Curves.easeOutBack,
                          duration: 600.ms,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const Color primaryColor = Color(0xFF1C1C3A);
const Color secondaryColor = Color(0xFFD4AF37);
