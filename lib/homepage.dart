import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laceup/mock_data.dart';
import 'package:laceup/my_cart.dart';
import 'package:laceup/shoe_detail_page.dart';
import 'package:laceup/splash.dart';
import 'package:laceup/widgets/animated_button.dart';
import 'dart:math' show pow;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = -1;
  late PageController _pageController;
  double currentPage = 0;
  List<Shoe> filteredShoes = [];
  Color color = Color(0xFFda5a65);
  double cartContainerOffset = 0.0;
  bool showSuccessAnimation = false;

  double _easeInOutCubic(double x) {
    return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2;
  }

  double _getShadowIntensity(double offset) {
    double normalizedOffset = (offset.abs() / 100).clamp(0, 1);
    return _easeInOutCubic(normalizedOffset);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (cartContainerOffset.abs() >= 90) {
      setState(() {
        showSuccessAnimation = true;
      });
      Future.delayed(Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            showSuccessAnimation = false;
          });
        }
      });
    }
    setState(() {
      cartContainerOffset = 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.73);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0;
        // Update color based on current page
        if (filteredShoes.isNotEmpty) {
          int currentIndex = currentPage.round();
          if (currentIndex >= 0 && currentIndex < filteredShoes.length) {
            color = Color(int.parse(filteredShoes[currentIndex].color));
          }
        }
      });
    });
    filteredShoes = mockShoes;
  }

  void _filterShoes(String? brand) {
    setState(() {
      if (brand == null) {
        filteredShoes = mockShoes;
      } else {
        filteredShoes = mockShoes.where((shoe) => shoe.brand == brand).toList();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Row(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Lace',
                  style: GoogleFonts.playpenSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Hero(
                  tag: 'splash',
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: secondaryColor,
                    ),
                    child: Center(
                      child:
                          Text(
                            "UP",
                            style: GoogleFonts.akayaKanadaka(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ).animate(delay: 800.ms).fade(),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/search.svg'),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCart()),
                  );
                },
                icon: SvgPicture.asset('assets/icons/cart.svg'),
              ),
              SizedBox(width: 6),
            ],
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16, bottom: 16),
                child: Text(
                  'Categories',
                  style: GoogleFonts.lexend(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),

              Container(
                height: 40,
                margin: EdgeInsets.only(bottom: 30),
                color: Colors.transparent,
                width: double.infinity,
                child: Builder(
                  builder: (context) {
                    final uniqueBrands =
                        mockShoes.map((shoe) => shoe.brand).toSet().toList();

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: uniqueBrands.length,
                      itemBuilder: (context, index) {
                        final brand = uniqueBrands[index];
                        bool selected = currentIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: AnimatedButton(
                            onTap: () {
                              setState(() {
                                if (currentIndex == index) {
                                  currentIndex = -1;
                                  _filterShoes(null);
                                } else {
                                  currentIndex = index;
                                  _filterShoes(brand);
                                }
                              });
                            },
                            firstText: brand,
                            selected: selected,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height / 2.5,
                color: Colors.transparent,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: filteredShoes.length,
                  itemBuilder: (context, index) {
                    final shoe = filteredShoes[index];
                    final pageOffset = index - currentPage;
                    final rotation = -0.6 + (pageOffset * .6);
                    final scale = 1.0 - (pageOffset.abs() * 0.6);
                    final containerScale = 1.0 - (pageOffset.abs() * 0.1);
                    final opacity = 1.0 - (pageOffset.abs() * 0.3);
                    final elevation = 8.0 - (pageOffset.abs() * 4.0);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ShoeDetailPage(shoe: shoe),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Hero(
                            tag: '${shoe.name}_container',
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
                                    padding: EdgeInsets.all(12),
                                    height: double.infinity,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(right: 32, left: 16),
                                    duration: Duration(milliseconds: 900),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(
                                        int.parse(shoe.color),
                                      ).withValues(alpha: opacity),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                          blurRadius: elevation,
                                          offset: Offset(0, elevation / 2),
                                        ),
                                      ],
                                    ),
                                    transform:
                                        Matrix4.identity()..scale(containerScale),
                                    transformAlignment: Alignment.center,
                                  );
                                },
                              );
                            },
                            createRectTween: (Rect? begin, Rect? end) {
                              return MaterialRectArcTween(begin: begin, end: end);
                            },
                            child: AnimatedContainer(
                              padding: EdgeInsets.all(12),
                              height: double.infinity,
                              width: double.infinity,
                              margin: EdgeInsets.only(right: 32, left: 16),
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(
                                  int.parse(shoe.color),
                                ).withValues(alpha: opacity),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: elevation,
                                    offset: Offset(0, elevation / 2),
                                  ),
                                ],
                              ),
                              transform: Matrix4.identity()..scale(containerScale),
                              transformAlignment: Alignment.center,
                            ),
                          ),
                          Positioned(
                            right: -2,
                            bottom: 50,
                            child: Hero(
                              tag: '${shoe.name}_image',
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
                                      child: Transform.scale(
                                        scale: scale,
                                        child: Image.asset(
                                          shoe.image,
                                          height: 180,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Transform.rotate(
                                angle: rotation,
                                child: Transform.scale(
                                  scale: scale,
                                  child: Image.asset(
                                    shoe.image,
                                    height: 180,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 30,
                            child: SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shoe.brand,
                                        style: GoogleFonts.playpenSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        shoe.name,
                                        style: GoogleFonts.playpenSans(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        shoe.price,
                                        style: GoogleFonts.playpenSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                                .animate(delay: 300.ms)
                                .scale(
                                  begin: Offset(0.7, 0.7),
                                  end: Offset(0.9, 0.9),
                                  duration: 400.ms,
                                  curve: Curves.easeOut,
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: AnimatedContainer(
                  width: double.infinity,
                  duration: 200.ms,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        bottom: -230,
                        child: AnimatedContainer(
                          duration: 200.ms,
                          height: 440,
                          width: 600,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5 + (_getShadowIntensity(cartContainerOffset) * 0.5)),
                                blurRadius: 15 + (_getShadowIntensity(cartContainerOffset) * 20),
                                offset: Offset(0, 5 - (_getShadowIntensity(cartContainerOffset) * 15)),
                              ),
                            ],
                            color: color,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('Swipe to add to cart',style: GoogleFonts.playpenSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),)],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        child: AnimatedContainer(
                          padding: EdgeInsets.all(2),
                          duration: 200.ms,
                          height: 180,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(color: color, width: 4),
                            color: Colors.white,
                         
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: color.withValues(alpha: 0.5),
                                        size: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: color.withValues(alpha: 0.7),
                                          size: 32,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: color,
                                          size: 34,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                
                                child: GestureDetector(
                                  onVerticalDragUpdate: (details) {
                                    setState(() {
                                      cartContainerOffset += details.delta.dy;
                                      // Limit the drag range
                                      cartContainerOffset = cartContainerOffset.clamp(-50.0, 100.0);
                                    });
                                  },
                                  onVerticalDragEnd: _handleDragEnd,
                                  child: AnimatedContainer(
                                    transform: Matrix4.translationValues(0, cartContainerOffset, 0),
                                    duration: 200.ms,
                                    height: 70,
                                    padding: EdgeInsets.all(16),
                                    width: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/cart.svg',
                                      colorFilter: ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                      height: 14,
                                      width: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showSuccessAnimation)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Stack(
                    children: [
                      ...List.generate(3, (index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeOut,
                          margin: EdgeInsets.all(10 * index.toDouble()),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: color.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                        ).animate(
                          onPlay: (controller) => controller.repeat(),
                        ).scale(
                          begin: Offset(0.5, 0.5),
                          end: Offset(1.5, 1.5),
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeOut,
                        ).fadeOut();
                      }),
                      Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 50,
                        ).animate().scale(
                          begin: Offset(0.5, 0.5),
                          end: Offset(1, 1),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.elasticOut,
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(
                  begin: Offset(0.5, 0.5),
                  end: Offset(1, 1),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                ),
              ),
            ),
          ).animate().fadeIn(
            duration: Duration(milliseconds: 300),
          ),
      ],
    );
  }
}
