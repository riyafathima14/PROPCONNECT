

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/verification_screen2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:propconnect/services/api_service.dart';

class VerificationScreen1 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String encryptedPassword;
  final String username;

  const VerificationScreen1({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.encryptedPassword,
  });

  @override
  State<VerificationScreen1> createState() => _VerificationScreen1State();
}

class _VerificationScreen1State extends State<VerificationScreen1> {
  bool isMobileSelected = false;
  bool isEmailSelected = false;
  bool isOTPSending = false;
  String errorMessage = "";

  Future<void> _requestOTP() async {
    setState(() {
      isOTPSending = true;
      errorMessage = "";
    });

    String contactInfo = isEmailSelected ? widget.email : widget.phone;
    String method = isEmailSelected ? "email" : "phone";

    try {
      print(jsonEncode({
      "first_name": widget.firstName,
     "last_name": widget.lastName,
     "email": widget.email.isNotEmpty ? widget.email : null,
     "phone": widget.phone.isNotEmpty ? widget.phone : null,
     "password": widget.encryptedPassword,
      }));

      final response = await http.post(
        Uri.parse("https://9fa2-2403-a080-1006-3f86-dc54-9114-67b7-b581.ngrok-free.app/auth/send-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "first_name": widget.firstName,
          "last_name": widget.lastName,
          "email": widget.email,
          "phone": widget.phone,
          "user_name": widget.username,
          "password": widget.encryptedPassword,
        }),
      );
      if (response.statusCode == 200) {
        print("OTP sent successfully!");

        _navigateToVerificationScreen2();
      } else {
        setState(() {
          errorMessage = "Failed to send OTP. Try again. ";
        });
        print("Failed to send OTP: ${response.body}");
      }
    } catch (e) {
      setState(() {
        errorMessage = "Network error. Please check your connection.";
      });
      print("Error sending OTP: $e");
    } finally {
      setState(() {
        isOTPSending = false;
      });
    }
  }


  void _navigateToVerificationScreen2() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => VerificationScreen2(
              firstName: widget.firstName,
              lastName: widget.lastName,
              email: widget.email,
              phone: widget.phone,
              username: widget.username,
              encryptedPassword: widget.encryptedPassword,
              isEmailSelected: isEmailSelected,
              isMobileSelected: isMobileSelected,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/signin_img1.png',
                // width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(height: 20),
              Text(
                "Choose Verification Method",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMobileSelected = true;
                    isEmailSelected = false;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 85,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isMobileSelected
                              ? const Color(0xFF204ECF)
                              : const Color(0xFFD9D9D9),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Color(0xFF204ECF),
                          size: 38,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Via Mobile Number",
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            if (isMobileSelected) ...[
                              //const SizedBox(height: 5),
                              Text(
                                widget.phone,
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: Color(0XFF204ECF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMobileSelected = false;
                    isEmailSelected = true;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 85,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isEmailSelected
                              ? const Color(0xFF204ECF)
                              : const Color(0xFFD9D9D9),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.email,
                          color: Color(0xFF204ECF),
                          size: 38,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Via Email",
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            if (isEmailSelected) ...[
                              Text(
                                widget.email,
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: Color(0XFF204ECF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (!isMobileSelected && !isEmailSelected) {
                    print("No verification method selected!");
                    return;
                  }

                  // Prepare payload
                  final Map<String, dynamic> requestBody = {
                    "first_name": widget.firstName,
                    "last_name": widget.lastName,
                    "email": widget.email.isNotEmpty ? widget.email : null,
                    "phone": widget.phone.isNotEmpty ? widget.phone : null,
                    "user_name": widget.username,
                    "password": widget.encryptedPassword,
                  };

                  try {
                    final response = await http.post(
                      Uri.parse(
                        "https://8fa4-2403-a080-1004-a111-25e7-6fd0-448b-ba9b.ngrok-free.app/auth/send-otp",
                      ), // Replace with your Flask backend IP
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode(requestBody),
                    );

                    if (response.statusCode == 200) {
                      print("OTP sent successfully!");

                      // Navigate to VerificationScreen2 only after OTP is sent
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  VerificationScreen2(
                                    firstName: widget.firstName,
                                    lastName: widget.lastName,
                                    email: widget.email,
                                    phone: widget.phone,
                                    username: widget.username,
                                    encryptedPassword: widget.encryptedPassword,
                                    isEmailSelected: isEmailSelected,
                                    isMobileSelected: isMobileSelected,
                                  ),
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
                    } else {
                      print("Failed to send OTP: ${response.body}");
                    }
                  } catch (e) {
                    print("Error sending OTP: $e");
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204ECF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child:
                    isOTPSending
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                          "Continue",
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
