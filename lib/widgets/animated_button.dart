import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laceup/widgets/custom_loading.dart';
import '../splash.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onTap;
  final String firstText;
  final String secondText;
  final bool selected;
  final Color color;
  final bool loading;

  const AnimatedButton({
    super.key,
    required this.onTap,
    required this.firstText,
    this.secondText = '',
    this.selected = false,
    this.color = secondaryColor,
    this.loading = false,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),

        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color, widget.color.withValues(alpha: 0.2)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: widget.loading ? Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: CustomLoading(),
          ) : Stack(

            children: [
              AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.firstText,
                        style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .animate(target: widget.selected ? 1 : 0)
                  .scaleY(end: 0, alignment: Alignment.bottomCenter),
              AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.secondText.isEmpty
                            ? widget.firstText
                            : widget.secondText,
                        style:  GoogleFonts.lexend(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .animate(target: widget.selected ? 1 : 0)
                  .scaleY(begin: 0, alignment: Alignment.topCenter, end: 1),
            ],
          ),
        ),
      ),
    );
  }
}
