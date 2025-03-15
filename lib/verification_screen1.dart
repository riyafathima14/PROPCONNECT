import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen1 extends StatelessWidget {
  const VerificationScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 10),

              

              const SizedBox(height: 20),

              // Image
              Image.asset(
                'assets/images/signin_img1.png',
                width: 250,
                height: 180,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                "Choose Verification Method",
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              // Mobile Verification Option
              GestureDetector(
                onTap: () {
                  // Handle mobile number verification
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, color: Color(0xFF204ECF)),
                      const SizedBox(width: 10),
                      Text(
                        "Via Mobile Number",
                        style: GoogleFonts.nunito(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Email Verification Option
              GestureDetector(
                onTap: () {
                  // Handle email verification
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email, color: Color(0xFF204ECF)),
                      const SizedBox(width: 10),
                      Text(
                        "Via Email",
                        style: GoogleFonts.nunito(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Continue Button
              ElevatedButton(
                onPressed: () {
                  // Handle continue action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204ECF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  "Continue",
                  style: GoogleFonts.nunito(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
