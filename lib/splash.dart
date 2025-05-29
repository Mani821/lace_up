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
    Future.delayed(const Duration(milliseconds: 2600), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1900),
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Lace',
                      style: GoogleFonts.playpenSans(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    // Text(
                    //   'Love',
                    //   style: GoogleFonts.playpenSans(
                    //     fontSize: 40,
                    //     fontWeight: FontWeight.bold,
                    //     color: primaryColor,
                    //   ),
                    // ).animate(delay: 5400.ms).flipV(begin: 0.5,end: 0,duration: 600.ms,alignment: Alignment.bottomCenter).animate(delay: 5800.ms).flipV(begin: 0,end: -.5,duration: 600.ms,alignment: Alignment.bottomCenter,delay: 600.ms),
                    // Text(
                    //   'Live',
                    //   style: GoogleFonts.playpenSans(
                    //     fontSize: 40,
                    //     fontWeight: FontWeight.bold,
                    //     color: primaryColor,
                    //   ),
                    // ).animate(delay: 7000.ms).flipV(begin: 0.5,end: 0,duration: 600.ms,alignment: Alignment.bottomCenter),
                  ],
                ),
                Hero(
                  tag: 'splash',
                  child: Stack(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        color: secondaryColor,
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
                            // .animate(delay: 1600.ms)
                            // .moveY(
                            //   begin: -2,
                            //   end: -80,
                            //   delay: 1400.ms,
                            //   curve: Curves.easeInBack,
                            //   duration: 600.ms,
                            // ),
                            // Text(
                            //   "IT",
                            //   style: GoogleFonts.akayaKanadaka(
                            //     fontSize: 40,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.white,
                            //   ),
                            // ).animate().moveY(
                            //   begin: 80,
                            //   end: -2,
                            //   delay: 3500.ms,
                            //   curve: Curves.easeOutBack,
                            //   duration: 600.ms,
                            // ),
                          ],
                        ),
                      ),
                    ],
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
