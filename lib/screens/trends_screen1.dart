import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/favorites_screen.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:propconnect/screens/profile_screen1.dart';
import 'package:propconnect/screens/trends_screen2.dart';

class TrendsScreen1 extends StatefulWidget {
  const TrendsScreen1({super.key});

  @override
  State<TrendsScreen1> createState() => _TrendsScreen1State();
}

class _TrendsScreen1State extends State<TrendsScreen1> {
  String activeTab = "Trends";

  void navigateTo(String tabName, Widget screen, BuildContext context) {
    setState(() {
      activeTab = tabName;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  final List<String> cities = [
    "Mumbai",
    "Bengaluru",
    "Chennai",
    "Kerala",
    "Delhi",
    "Kolkata",
    "Hyderabad",
    "Pune",
  ];

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
  body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: cities.map((city) => _buildCityRow(city, context)).toList(),
        ),
      ), 
      bottomNavigationBar: _buildBottomNavBar(screenWidth),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: const Color(0xFF204ECF),
        onPressed: () {
          // Add navigation for floating button
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavBar(double screenWidth) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.white,
      shadowColor: Color.fromARGB(255, 93, 91, 91),
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
                    isActive: activeTab=="Trends",
                    onTap: () {
                      navigateTo("Favorites", const TrendsScreen1(), context);
                    },
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
              bottom: 1, // Position below the FAB
              child: Text(
                'Sell',
                style: GoogleFonts.nunito(
                  color: Color(0xFF787171),
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
            color: isActive ? Color(0xFF204ECF) : Color(0xFFD9D9D9),
          ),
          Text(
            label,
            style: GoogleFonts.nunito(color: Color(0xFF787171), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
Widget _buildCityRow(String city, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrendsScreen2(cityName: city),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }

