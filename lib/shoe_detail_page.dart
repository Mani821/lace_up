import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laceup/mock_data.dart';
import 'package:laceup/splash.dart';
import 'package:laceup/widgets/animated_button.dart';

class ShoeDetailPage extends StatefulWidget {
  final Shoe shoe;
  const ShoeDetailPage({super.key, required this.shoe});

  @override
  State<ShoeDetailPage> createState() => _ShoeDetailPageState();
}

class _ShoeDetailPageState extends State<ShoeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: 330,
            child: Stack(
              children: [
                Positioned(
                  top: -270,
                  left: -5,
                  child: Hero(
                    tag: '${widget.shoe.name}_container',
                    flightShuttleBuilder: (
                      BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext,
                    ) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return AnimatedContainer(
                            duration: 200.ms,
                            height: 580,
                            width: 580,
                            decoration: BoxDecoration(
                              color: Color(int.parse(widget.shoe.color)),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      );
                    },
                    createRectTween: (Rect? begin, Rect? end) {
                      return MaterialRectArcTween(begin: begin, end: end);
                    },
                    child: AnimatedContainer(
                      duration: 200.ms,
                      height: 580,
                      width: 580,
                      decoration: BoxDecoration(
                        color: Color(int.parse(widget.shoe.color)),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  right: 20,
                  child: Hero(
                    tag: '${widget.shoe.name}_image',
                    flightShuttleBuilder: (
                      BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext,
                    ) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: -0.6 + (animation.value * 0.4),
                            child: Image.asset(
                              widget.shoe.image,
                              height: 240,
                              width: 240,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    },
                    child: Transform.rotate(
                      angle: -0.2,
                      child: Image.asset(
                        widget.shoe.image,
                        height: 240,
                        width: 240,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 20,
                    children: [
                      Flexible(
                        child:
                            Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: widget.shoe.name,
                                        style: GoogleFonts.playpenSans(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " - ${widget.shoe.brand}",
                                        style: GoogleFonts.playpenSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .animate(delay: 600.ms)
                                .moveY(
                                  begin: 10,
                                  end: 0,
                                  duration: 600.ms,
                                  curve: Curves.easeInOut,
                                )
                                .fade(),
                      ),
                      Text(
                            widget.shoe.price,
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          )
                          .animate(delay: 600.ms)
                          .moveY(
                            begin: 10,
                            end: 0,
                            duration: 600.ms,
                            curve: Curves.easeInOut,
                          )
                          .fade(),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                        widget.shoe.description,
                        style: GoogleFonts.lexend(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      )
                      .animate(delay: 1300.ms)
                      .moveY(
                        begin: 10,
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.easeInOut,
                      )
                      .fade(),
                  SizedBox(height: 26),
                  Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Size",
                              style: GoogleFonts.lexend(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(2, (index) {
                              return Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor,
                                ),
                              );
                            }),
                          ),
                        ],
                      )
                      .animate(delay: 1900.ms)
                      .moveY(
                        begin: 10,
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.easeInOut,
                      )
                      .fade(),
                  Spacer(),
                  SafeArea(
                    child: AnimatedButton(
                      onTap: () {},
                      firstText: "Add to cart",
                      color: Color(int.parse(widget.shoe.color)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
