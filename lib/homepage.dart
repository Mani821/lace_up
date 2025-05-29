import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laceup/mock_data.dart';
import 'package:laceup/shoe_detail_page.dart';
import 'package:laceup/splash.dart';
import 'package:laceup/widgets/animated_button.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = -1;
  late PageController _pageController;
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.73);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          spacing: 6,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'Lace',
                  style: GoogleFonts.playpenSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Hero(
              tag: 'splash',
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: secondaryColor,
                ),
                child: Center(
                  child:
                      Text(
                        "Up",
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
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/bell.svg'),
          ),
          SizedBox(width: 6),
        ],
      ),

      body: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(vertical: 30),
            color: Colors.transparent,
            width: double.infinity,
            child: Builder(
              builder: (context) {
                // Extract unique brands
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
                            } else {
                              currentIndex = index;
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
              itemCount: mockShoes.length,
              itemBuilder: (context, index) {
                final shoe = mockShoes[index];
                final pageOffset = index - currentPage;
                final rotation =
                    -0.6 +
                    (pageOffset * .6); // Adjust rotation based on page offset
                final scale =
                    1.0 -
                    (pageOffset.abs() *
                        0.6); // Scale down based on distance from current page
                final containerScale =
                    1.0 - (pageOffset.abs() * 0.1); // Container scale
                final opacity =
                    1.0 - (pageOffset.abs() * 0.3); // Opacity based on distance
                final elevation =
                    8.0 - (pageOffset.abs() * 4.0); // Dynamic elevation

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
                          height: double.infinity, // Fill the PageView height
                          width: double.infinity, // Fill the PageView width
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
                            ),
                            Text(
                              shoe.name,
                              style: GoogleFonts.playpenSans(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              shoe.price,
                              style: GoogleFonts.playpenSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
