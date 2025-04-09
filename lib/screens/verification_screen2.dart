import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/providers/user_provider.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String username;
  final String encryptedPassword;
  final bool isEmailSelected;
  final bool isMobileSelected;

  const VerificationScreen2({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.encryptedPassword,
    required this.isEmailSelected,
    required this.isMobileSelected,
  });

  @override
  State<VerificationScreen2> createState() => _VerificationScreen2State();
}

class _VerificationScreen2State extends State<VerificationScreen2> {
  int _secondsRemaining = 59;
  Timer? _timer;

  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
  
Future<void> saveLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
}
  Future<void> _verifyOtp() async {
  final enteredOtp = _controllers.map((controller) => controller.text).join();

  print("Entered OTP: $enteredOtp");
  print("Username being sent: ${widget.username}");

  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.3:5000/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'otp': enteredOtp,
        'username': widget.username,
        'email': widget.email.isNotEmpty ? widget.email : "",
        'phone': widget.phone.isNotEmpty ? widget.phone : "",
      }),
    );

    final data = jsonDecode(response.body);
    print('Response from server: $data'); // 👈 print full response

    if (data['message'] == 'OTP verified, user registered successfully!') {
      if (!mounted) return; 

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified. User Registered')),
      );
      await saveLoginStatus();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.updateUserData(
        userId: data['userId'].toString(),  // adjust according to your response
        username: data['username'],
        email: data['email'],
        phone: data['phone'],
      );
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Verification failed')),
      );
    }
  } catch (e) {
    print('Error during OTP verification: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error verifying OTP. Please try again.')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents UI from moving up when keyboard appears
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.05,
              ),
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
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Image.asset(
                    'assets/images/signin_img1.png',
                    height: constraints.maxHeight * 0.3,
                    width: constraints.maxWidth * 0.7,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Text(
                    widget.isEmailSelected
                        ? "Verify Your Email"
                        : "Verify Your Mobile Number",
                    style: GoogleFonts.nunito(
                      fontSize: constraints.maxWidth * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OTP has been sent to ",
                        style: GoogleFonts.nunito(
                          color: const Color(0XFF787171),
                          fontSize: constraints.maxWidth * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.isEmailSelected ? widget.email : widget.phone,
                        style: GoogleFonts.nunito(
                          color: const Color(0XFF204ECF),
                          fontSize: constraints.maxWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        width: constraints.maxWidth * 0.15,
                        height: constraints.maxWidth * 0.15,
                        margin: EdgeInsets.all(constraints.maxWidth * 0.02),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _focusNodes[index].hasFocus
                                    ? const Color(0xFF204ECF)
                                    : const Color(0xFFD9D9D9),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          focusNode: _focusNodes[index],
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.05,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resend Code in ",
                        style: GoogleFonts.nunito(
                          color: const Color(0xFF434343),
                          fontWeight: FontWeight.w600,
                          fontSize: constraints.maxWidth * 0.04,
                        ),
                      ),
                      Text(
                        _secondsRemaining.toString(),
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2639ED),
                          fontSize: constraints.maxWidth * 0.045,
                        ),
                      ),
                      Text(
                        " secs ",
                        style: GoogleFonts.nunito(
                          color: const Color(0xFF434343),
                          fontWeight: FontWeight.w600,
                          fontSize: constraints.maxWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await _verifyOtp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF204ECF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(constraints.maxWidth, 50),
                    ),
                    child: Text(
                      "Verify",
                      style: GoogleFonts.nunito(
                        fontSize: constraints.maxWidth * 0.045,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
