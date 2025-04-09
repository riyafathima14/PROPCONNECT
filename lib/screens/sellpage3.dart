import 'package:flutter/material.dart';

class Sellpage3 extends StatelessWidget {
  const Sellpage3({Key? key}) : super(key: key);

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
      // ========== BODY ==========
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const SizedBox(height: 20),
              const Text(
                "Add Photos & Details",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Step 1 of 3",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff787171),
                ),
              ),
              const SizedBox(height: 24),

              // Subtitle
              const Text(
                "Add property photos",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Upload Container
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon or image placeholder
                      Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "+Add atleast 2 images",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Image upload note
              Text(
                "Upload upto 5 images of max size 5 mb in format png,jpg,jpeg",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),

              // Ownership document note
              const Text(
                "*Please provide ownership document of property,\notherwise your listing might get blocked",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 24),

              // Upload button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement your upload logic
                  },
                  icon: const Icon(Icons.upload, color: Colors.black54),
                  label: const Text(
                    "Upload",
                    style: TextStyle(color: Colors.black54),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              // Spacer
              const SizedBox(height: 40),

              // Next button at bottom
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to next step
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF204ECF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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
}
