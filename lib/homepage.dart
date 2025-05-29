import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text.rich(
          TextSpan(
            text: 'Lace',
            style:GoogleFonts.playpenSans(fontWeight: FontWeight.w600,color: Color(0xFF1E90FF)),
            children: [
              TextSpan(
                text: 'Up',
                style: GoogleFonts.kalam(fontWeight: FontWeight.w600,color: Color(0xFF000000),fontSize: 26),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
