import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/favorites_screen.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:propconnect/screens/changepassword_screen.dart';
import 'package:propconnect/screens/signin_page1.dart';
import 'package:propconnect/screens/trends_screen1.dart';

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ProfileScreen1> {
  String activeTab = "Profile";

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
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Profile",
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

            const SizedBox(height: 20),
            CircleAvatar(
              radius: screenWidth * 0.15,
              backgroundColor: Colors.white,
              child: Image.asset(
                "assets/images/profile_img.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "riyafathimakp38@gmail.com",
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "+919074103337",
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.04,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {},
              child: Text(
                "Edit Your Profile",
                style: GoogleFonts.nunito(
                  color: Color(0xFF204ECF),
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
            const SizedBox(height: 50),
            _buildProfileOption(
              "Change Password",
              Icons.arrow_forward_ios,
              screenWidth,
            ),
            const SizedBox(height: 10),
            _buildProfileOption("Logout", Icons.arrow_forward_ios, screenWidth),
          ],
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

  Widget _buildProfileOption(String title, IconData icon, double screenWidth) {
    return GestureDetector(
      onTap: () {
        title == 'Change Password'
            ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen(),
              ),
            )
            : Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SigninPage1()),
            );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffD9d9d9)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(icon, size: screenWidth * 0.05, color: Color(0xFF434343)),
          ],
        ),
      ),
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
                        isActive: activeTab == "Trends",
                        onTap: () {
                          navigateTo("Trends", const TrendsScreen1(), context);
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
