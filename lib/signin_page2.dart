import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/homepage.dart';
import 'package:propconnect/signin_page1.dart';

class SigninPage2 extends StatefulWidget {
  const SigninPage2({super.key});

  @override
  State<SigninPage2> createState() => _SigninPage2State();
}

class _SigninPage2State extends State<SigninPage2> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder:
                    (context, animation, secondaryAnimation) =>
                        const SigninPage1(),
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
                  return FadeTransition(opacity: fadeAnimation, child: child);
                },
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          bool isMobile = screenWidth < 600;

          return Column(
            children: [
              // Centered content (Image + TextFields)
              Expanded(
                child: Center(
                  child: Container(
                    width: isMobile ? screenWidth * 0.9 : 400,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/signin_img1.png',
                          width: 251,
                          height: 251,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Sign in to your Account",
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField("Username", Icons.person),
                        const SizedBox(height: 15),
                        _buildPasswordField(),
                      ],
                    ),
                  ),
                ),
              ),

              // Sign-in Button at Bottom
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF204ECF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context )=> HomePage()));
                    },
                    child: Text(
                      "Sign in",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon) {
    return TextField(
      style: GoogleFonts.nunito(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ), // Ensuring black text with bold weight
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        prefixIcon: Icon(icon, size: 24, color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xff204ECF), width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      obscureText: !_isPasswordVisible,
      style: GoogleFonts.nunito(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ), // Ensuring black text with bold weight
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: GoogleFonts.nunito(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        prefixIcon: const Icon(
          Icons.lock_rounded,
          size: 24,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xff204ECF), width: 2),
        ),
      ),
    );
  }
}
