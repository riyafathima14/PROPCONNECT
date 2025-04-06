import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/favorites_screen.dart';
import 'package:propconnect/profile_screen1.dart';
import 'package:propconnect/search_screen1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   String activeTab = "Home"; // Default active tab

  void navigateTo(String tabName, Widget screen, BuildContext context) {
    setState(() {
      activeTab = tabName;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double iconSize = screenSize.width * 0.08;
    final double optionSize = screenSize.width * 0.25;
    final double textSize = screenSize.width * 0.035;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: screenSize.height * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home_img1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.02,
                  
                  right: -10,
                  
                  child: Image.asset(
                    'assets/images/logoblue.png',
                    height: screenSize.height * 0.07,
                  ),
                ),
      
                Positioned(
                  bottom: -screenSize.height * 0.04,
                  left: screenSize.width * 0.05,
                  right: screenSize.width * 0.05,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const SearchScreen1(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            var fadeAnimation = Tween(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(animation);
                            return FadeTransition(
                              opacity: fadeAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: screenSize.height * 0.07,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: const Color(0XFF9E9BA2),
                            size: iconSize,
                          ),
                          SizedBox(width: screenSize.width * 0.03),
                          Text(
                            "Search",
                            style: GoogleFonts.nunito(
                              fontSize: textSize,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF9E9BA2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.06),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.06,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get started with",
                            style: GoogleFonts.nunito(
                              fontSize: textSize * 1.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Text(
                            "Explore real estate options in top cities",
                            style: GoogleFonts.nunito(
                              fontSize: textSize * 0.8,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF8B8B8B),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Container(
                            padding: EdgeInsets.all(screenSize.width * 0.04),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Color(0xFFDADADA),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildOption(
                                  "assets/images/buyicon.png",
                                  "Buy",
                                  optionSize,
                                  textSize,
                                ),
                                _buildOption(
                                  "assets/images/sellicon.png",
                                  "Sell",
                                  optionSize,
                                  textSize,
                                ),
                                _buildOption(
                                  "assets/images/renticon.png",
                                  "Rent/Pg",
                                  optionSize,
                                  textSize,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Container(
                      color: Color(0xFFE6F0FF),
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            _buildScrollableCard(
                              "assets/images/recommendations.png",
                              "Recommendations",
                            ),
                            _buildScrollableCard(
                              "assets/images/prizetrends.png",
                              "Price Trends",
                            ),
                            _buildScrollableCard(
                              "assets/images/reviews.png",
                              "Reviews",
                            ),
                            SizedBox(width: 15),
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
        bottomNavigationBar: BottomAppBar(
  shape: const CircularNotchedRectangle(),
  color:Colors.white,
  shadowColor: Color.fromARGB(255, 93, 91, 91),
  notchMargin: 6.0,
  child: SizedBox(
    height: 70, // Slightly increased height for the "Sell" label
    child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem("assets/images/home_icon.png", "Home",
                          isActive: activeTab == "Home", onTap: () {
                        navigateTo("Home", const HomePage(), context);
                      }),
              _buildNavItem("assets/images/trends_icon.png", "Trends",
                          isActive: false),
              const SizedBox(width: 40), // Space for FAB
                _buildNavItem("assets/images/favorites_icon.png",
                          "Favourites",
                          isActive: activeTab == "Favorites", onTap: () {
                        navigateTo("Favorites", const FavoritesScreen(), context);
                      }),
               _buildNavItem("assets/images/profile_icon.png", "Profile",
                          isActive: activeTab == "Profile", onTap: () {
                        navigateTo("Profile", const ProfileScreen1(), context);
                      }),
            ],
          ),
        ),
        Positioned(
          bottom: 1, // Position below the FAB
          child: Text(
            'Sell',
            style: TextStyle(
              color: Color(0xFF787171),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  ),
),

        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor:Color(0xFF204ECF),
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 28, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
 Widget _buildNavItem(String iconPath, String label,
      {bool isActive = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 28, height: 28, color: isActive ? Color(0xFF204ECF) : Color(0xFFD9D9D9)),
          Text(
            label,
            style: TextStyle(color: Color(0xFF787171),fontSize: 12),
          ),
        ],
      ),
    );
  }
Widget _buildOption(
  String imagePath,
  String label,
  double size,
  double textSize,
) {
  return Column(
    children: [
      Container(
        width: size,
        height: size * 1.1258,
        padding: EdgeInsets.all(size * 0.1),
        decoration: BoxDecoration(
          color: Color(0xFFE6F0FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFFDADADA), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size * 0.7,
              width: size * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(child: Image.asset(imagePath, height: size * 0.5)),
            ),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: textSize,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: size * 0.08),
    ],
  );
}

Widget _buildScrollableCard(String imagePath, String label) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Container(
      width: 148,
      height: 135,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 80, width: 80),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
