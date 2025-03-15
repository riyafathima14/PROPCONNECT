import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/signin_page2.dart';
import 'package:propconnect/verification_screen1.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      // Flexible(
      //   fit: FlexFit.tight,
      //   child: Image.asset(
      //       'assets/images/propconnectlogo1.png',
      //       color: Color(0XFF204ECF),
      //       height: 13,
            
      //   ),
      // ),
    ],
  ),
),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create new Account",
                style: GoogleFonts.nunito(
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF204ECF),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Enter your information",
                style: GoogleFonts.nunito(
                  fontSize: screenHeight * 0.02,
                  color: const Color(0XFFD9D9D9),
                ),
              ),

              SizedBox(height: screenHeight * 0.01),
              _buildNameFields(screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField("Email", screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField("Phone Number", screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField("Username", screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField(
                "Password",
                screenHeight,
                isPassword: true,
              ),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField(
                "Confirm Password",
                screenHeight,
                isPassword: true,
              ),

              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF204ECF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                const VerificationScreen1(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          var begin = 0.0;
                          var end = 1.0;
                          var tween = Tween(begin: begin, end: end);
                          var fadeAnimation = animation.drive(tween);
                          return FadeTransition(
                            opacity: fadeAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  
                  child: Text(
                    "Continue",
                    style: GoogleFonts.nunito(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.004),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                const SigninPage2(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          var begin = 0.0;
                          var end = 1.0;
                          var tween = Tween(begin: begin, end: end);
                          var fadeAnimation = animation.drive(tween);
                          return FadeTransition(
                            opacity: fadeAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account? Log in",
                    style: GoogleFonts.nunito(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameFields(double screenHeight) {
    return Row(
      children: [
        Expanded(child: _buildLabeledTextField("First Name", screenHeight)),
        SizedBox(width: screenHeight * 0.01),
        Expanded(child: _buildLabeledTextField("Last Name", screenHeight)),
      ],
    );
  }

  Widget _buildLabeledTextField(
    String label,
    double screenHeight, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: screenHeight * 0.02,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: screenHeight * 0.002),
        SizedBox(
          height: screenHeight * 0.07,
          child: TextField(
            obscureText: isPassword,
            style: GoogleFonts.nunito(
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFF204ECF),
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenHeight * 0.02,
              ),
            ),
            cursorColor: const Color(0xFF204ECF),
          ),
        ),
      ],
    );
  }
}
