import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laceup/mock_data.dart';
import 'package:laceup/splash.dart';

class ShoeSize {
  final String system;
  final List<double> sizes;

  const ShoeSize({required this.system, required this.sizes});
}

class ShoeDetailPage extends StatefulWidget {
  final Shoe shoe;
  const ShoeDetailPage({super.key, required this.shoe});

  @override
  State<ShoeDetailPage> createState() => _ShoeDetailPageState();
}

class _ShoeDetailPageState extends State<ShoeDetailPage> {
  int selected = 0;
  double? selectedSize;

  final List<ShoeSize> sizeSystems = [
    ShoeSize(
      system: 'UK',
      sizes: [
        4,
        4.5,
        5,
        5.5,
        6,
        6.5,
        7,
        7.5,
        8,
        8.5,
        9,
        9.5,
        10,
        10.5,
        11,
        11.5,
        12,
        12.5,
        13,
      ],
    ),
    ShoeSize(
      system: 'US',
      sizes: [
        5,
        5.5,
        6,
        6.5,
        7,
        7.5,
        8,
        8.5,
        9,
        9.5,
        10,
        10.5,
        11,
        11.5,
        12,
        12.5,
        13,
        13.5,
        14,
      ],
    ),
  ];

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
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
                                    .animate(delay: 400.ms)
                                    .moveY(
                                      begin: 10,
                                      end: 0,
                                      duration: 500.ms,
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
                              .animate(delay: 400.ms)
                              .moveY(
                                begin: 10,
                                end: 0,
                                duration: 500.ms,
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
                          .animate(delay: 800.ms)
                          .moveY(
                            begin: 10,
                            end: 0,
                            duration: 500.ms,
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
                                spacing: 10,
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(sizeSystems.length, (
                                  index,
                                ) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                        selectedSize = null;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: 200.ms,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              selected != index
                                                  ? Color(
                                                    int.parse(
                                                      widget.shoe.color,
                                                    ),
                                                  )
                                                  : Colors.transparent,
                                        ),
                                        color:
                                            selected == index
                                                ? Color(
                                                  int.parse(widget.shoe.color),
                                                )
                                                : Colors.transparent,
                                      ),
                                      child: Text(
                                        sizeSystems[index].system,
                                        style: GoogleFonts.lexend(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              selected == index
                                                  ? Colors.white
                                                  : primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          )
                          .animate(delay: 1400.ms)
                          .moveY(
                            begin: 10,
                            end: 0,
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          )
                          .fade(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,

                        scrollDirection: Axis.horizontal,
                        itemCount: sizeSystems[selected].sizes.length,
                        itemBuilder: (context, index) {
                          final size = sizeSystems[selected].sizes[index];
                          final isSelected = selectedSize == size;
                          return Padding(
                            padding: EdgeInsets.only(
                              right: 16,
                              left: index == 0 ? 16 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = size;
                                });
                              },
                              child: AnimatedContainer(
                                duration: 200.ms,
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? Color(
                                              int.parse(widget.shoe.color),
                                            )
                                            : Colors.grey.shade300,
                                    width: isSelected ? 4 : 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                        size.toString(),
                                        style: GoogleFonts.lexend(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isSelected
                                                  ? primaryColor
                                                  : Colors.grey.shade600,
                                        ),
                                      )
                                      .animate(target: isSelected ? 1 : 0)
                                      .scaleXY(
                                        begin: 1,
                                        end: 1.3,
                                        duration: 200.ms,
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .animate(delay: 2000.ms)
                    .moveY(
                      begin: 10,
                      end: 0,
                        duration: 500.ms,
                      curve: Curves.easeInOut,
                    )
                    .fade(),
                Spacer(),
                SafeArea(
                  top: false,
                  child: Column(
                    children: List.generate(2, (index) {
                      return AnimatedContainer(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        duration: 200.ms,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(int.parse(widget.shoe.color)),
                          ),
                          color:
                              index == 0
                                  ? Colors.transparent
                                  : Color(int.parse(widget.shoe.color)),
                        ),
                        child: Center(
                          child: Text(
                            index == 0 ? "Add to cart" : "Buy now",
                            style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: index == 0 ? primaryColor : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
