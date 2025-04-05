import 'package:flutter/material.dart';
import 'package:propconnect/homepage.dart';
import 'package:propconnect/favorites_screen.dart';
import 'package:propconnect/profile_screen1.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

   @override
  State<ChangePasswordScreen> createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ChangePasswordScreen> {
  String activeTab = "Profile";

  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
      resizeToAvoidBottomInset: false, // Prevents body from resizing on keyboard
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Change Password",
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            _buildPasswordTextField(
              controller: _currentPasswordController,
              hintText: "Current Password",
              isVisible: _currentPasswordVisible,
              onVisibilityToggle: () {
                setState(() {
                  _currentPasswordVisible = !_currentPasswordVisible;
                });
              },
              screenWidth: screenWidth,
            ),
            const SizedBox(height: 25),
            _buildPasswordTextField(
              controller: _newPasswordController,
              hintText: "Enter New Password",
              isVisible: _newPasswordVisible,
              onVisibilityToggle: () {
                setState(() {
                  _newPasswordVisible = !_newPasswordVisible;
                });
              },
              screenWidth: screenWidth,
            ),
            const SizedBox(height: 25),
            _buildPasswordTextField(
              controller: _confirmPasswordController,
              hintText: "Confirm Password",
              isVisible: _confirmPasswordVisible,
              onVisibilityToggle: () {
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              },
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenHeight * 0.2),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Implement password change logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204ECF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Save",
                  style: GoogleFonts.nunito(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(screenWidth),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF204ECF),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required double screenWidth,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD9D9D9)),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: !isVisible,
          style: GoogleFonts.nunito(fontSize: screenWidth * 0.045),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.nunito(color: Colors.black54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: onVisibilityToggle,
            ),
          ),
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
