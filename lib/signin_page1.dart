import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/createaccount_screen.dart';
import 'package:propconnect/signin_page2.dart';

class SigninPage1 extends StatefulWidget {
  const SigninPage1({super.key});

  @override
  State<SigninPage1> createState() => _SigninPage1State();
}

class _SigninPage1State extends State<SigninPage1> {
  int _currentImageIndex = 0;
  final List<String> _imagePaths = [
    'assets/images/signin_img1.png',
    'assets/images/signin_img2.png',
    'assets/images/signin_img3.png',
  ];

  @override
  void initState() {
    super.initState();
    _startImageRotation();
  }

  void _startImageRotation() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leadingWidth: screenWidth * 0.7,
  leading: Padding(
    padding: const EdgeInsets.all(8.0), 
   child:Image.asset(
              'assets/images/logoblue.png',
              fit: BoxFit.contain,
              height: 14,
            ),
    ),
  ),


      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: SizedBox(
                height: screenHeight * 0.3,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    _imagePaths[_currentImageIndex],
                    key: ValueKey<String>(_imagePaths[_currentImageIndex]),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                children: [
                  // Google Sign-In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFFD9D9D9),
                            width: 1,
                          ),
                        ),
                       
                        child: Image.asset(
                          'assets/images/google.png',
                          height: screenHeight * 0.03,
                        ),
                      ),
                      label: Text(
                        "Continue with Google",
                        style: GoogleFonts.nunito(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFD9D9D9)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.018,
                        ),
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Facebook Sign-In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFFD9D9D9),
                            width: 1,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/facebook.png',
                          height: screenHeight * 0.03,
                        ),
                      ),
                      label: Text(
                        "Continue with Facebook",
                        style: GoogleFonts.nunito(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFD9D9D9)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.018,
                        ),
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.09),

                  // OR Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Text(
                          "or",
                          style: GoogleFonts.nunito(
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
            const Spacer(),

            // Bottom Section
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.04,
                left: screenWidth * 0.08,
                right: screenWidth * 0.08,
              ),
              child: Column(
                children: [
                 
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SigninPage2(),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              var fadeAnimation = Tween(begin: 0.0, end: 1.0)
                                  .animate(animation);
                              return FadeTransition(
                                opacity: fadeAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFD9D9D9)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.018,
                        ),
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Sign in with password",
                        style: GoogleFonts.nunito(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Sign Up Option
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CreateAccountScreen(),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            var fadeAnimation = Tween(begin: 0.0, end: 1.0)
                                .animate(animation);
                            return FadeTransition(
                              opacity: fadeAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
