import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:propconnect/screens/profile_screen1.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoriteScreen1State();
}

class _FavoriteScreen1State extends State<FavoritesScreen> {
  String activeTab = "Favorites";

  void navigateTo(String tabName, Widget screen, BuildContext context) {
    setState(() {
      activeTab = tabName;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: screenWidth * 0.7,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Image.asset(
              'assets/images/logoblue.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.02,
            ),
          ],
        ),
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: screenWidth/17),
        child: Column(children: [
          const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Favorites",
                  style: GoogleFonts.nunito(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Access all your top picks instantly!",
                  style: GoogleFonts.nunito(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.15,),
          _buildNoFavoritesUI(screenHeight, screenWidth),
        ],),
      ),
      bottomNavigationBar: _buildBottomNavBar(screenWidth),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF204ECF),
        onPressed: () {
          // Add navigation for floating button
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNoFavoritesUI(double screenHeight, double screenWidth) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nofavorite_img1.png',
              width: 104,
              height: 104,
            ),
            const SizedBox(height: 20),
            RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    style: GoogleFonts.nunito(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    children: [
      TextSpan(
        text: "You haven’t added\n",
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      const TextSpan(text: "any favourites yet."),
    ],
  ),
),

            const SizedBox(height: 10),
            Text(
              "Tap on the heart icon on property you like to see them here...",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: const Color(0xFF787171),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(double screenWidth) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.white,
      shadowColor: const Color.fromARGB(255, 93, 91, 91),
      notchMargin: 6.0,
      child: SizedBox(
        height: 70,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    "assets/images/home_icon.png",
                    "Home",
                    screenWidth: screenWidth,
                    isActive: activeTab == "Home",
                    onTap: () {
                      navigateTo("Home", const HomePage(), context);
                    },
                  ),
                  _buildNavItem(
                    "assets/images/trends_icon.png",
                    "Trends",
                    screenWidth: screenWidth,
                    isActive: false,
                  ),
                  const SizedBox(width: 40), // Space for FAB
                  _buildNavItem(
                    "assets/images/favorites_icon.png",
                    "Favourites",
                    screenWidth: screenWidth,
                    isActive: activeTab == "Favorites",
                    onTap: () {
                      navigateTo("Favorites", const FavoritesScreen(), context);
                    },
                  ),
                  _buildNavItem(
                    "assets/images/profile_icon.png",
                    "Profile",
                    screenWidth: screenWidth,
                    isActive: activeTab == "Profile",
                    onTap: () {
                      navigateTo("Profile", const ProfileScreen1(), context);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 1,
              child: Text(
                'Sell',
                style: GoogleFonts.nunito(
                  color: const Color(0xFF787171),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String iconPath,
    String label, {
    double? screenWidth,
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 28,
            height: 28,
            color: isActive ? const Color(0xFF204ECF) : const Color(0xFFD9D9D9),
          ),
          Text(
            label,
            style: GoogleFonts.nunito(color: const Color(0xFF787171), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
