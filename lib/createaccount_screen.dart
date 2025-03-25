import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/signin_page2.dart';
import 'package:propconnect/verification_screen1.dart';
import 'package:crypt/crypt.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
  backgroundColor: Colors.white,
  appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 220,
    leading: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Image.asset(
          'assets/images/logoblue.png',
          fit: BoxFit.contain,
          height: 14,
        ),
      ],
    ),
  ),
  body: GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard when tapped outside
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create new Account", style: _headerStyle(screenHeight)),
              SizedBox(height: screenHeight * 0.005),
              Text(
                "Enter your information",
                style: _subHeaderStyle(screenHeight),
              ),
              SizedBox(height: screenHeight * 0.005),
              _buildNameFields(screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField("Email", emailController, screenHeight,
                  validator: _validateEmail),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField(
                  "Phone Number", phoneController, screenHeight,
                  validator: _validatePhoneNumber),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField("Username", usernameController, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField("Password", passwordController, screenHeight,
                  isPassword: true),
              SizedBox(height: screenHeight * 0.01),
              _buildLabeledTextField(
                "Confirm Password",
                confirmPasswordController,
                screenHeight,
                isPassword: true,
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    ),
  ),
  bottomNavigationBar: SafeArea( // Prevent button from being covered by the keyboard
    child: Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
        bottom: screenHeight * 0.02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                if (_formKey.currentState!.validate()) {
                  String encryptedPassword = encryptPassword(
                    passwordController.text,
                  );
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          VerificationScreen1(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        username: usernameController.text,
                        encryptedPassword: encryptedPassword,
                      ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                }
              },
              child: Text("Continue", style: _buttonTextStyle(screenHeight)),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SigninPage2(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
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
                  fontWeight: FontWeight.w700,
                  color: Color(0XFFD9D9D9),
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
        Expanded(
          child: _buildLabeledTextField(
            "First Name",
            firstNameController,
            screenHeight,
          ),
        ),
        SizedBox(width: screenHeight * 0.02),
        Expanded(
          child: _buildLabeledTextField(
            "Last Name",
            lastNameController,
            screenHeight,
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledTextField(
    String label,
    TextEditingController controller,
    double screenHeight, {
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle(screenHeight)),
        SizedBox(height: screenHeight * 0.004),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator ?? _validateRequired,
          style: GoogleFonts.nunito(
            fontSize: screenHeight * 0.02,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.02,
              vertical: screenHeight * 0.018,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0XFFD9D9D9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFF204ECF), width: 2),
            ),
            errorStyle: TextStyle(
              fontSize: screenHeight * 0.01,
              color: Colors.red,
            ),
          ),
          cursorColor: const Color(0xFF204ECF),
        ),
      ],
    );
  }

  String? _validateRequired(String? value) {
    return (value == null || value.isEmpty) ? "This field is required" : null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$").hasMatch(value)) {
      return "Enter a valid Gmail address";
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return "Phone number is required";
    if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) return "Passwords do not match";
    return null;
  }

  TextStyle _headerStyle(double screenHeight) => GoogleFonts.nunito(
    fontSize: screenHeight * 0.032,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF204ECF),
  );

  TextStyle _subHeaderStyle(double screenHeight) => GoogleFonts.nunito(
    fontSize: screenHeight * 0.022,
    color: Color(0XFFD9D9D9),
  );

  TextStyle _labelStyle(double screenHeight) => GoogleFonts.nunito(
    fontSize: screenHeight * 0.02,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  TextStyle _buttonTextStyle(double screenHeight) => GoogleFonts.nunito(
    fontSize: screenHeight * 0.025,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  String encryptPassword(String password) {
    return Crypt.sha256(password, salt: 'random_salt_here').toString();
  }
}
