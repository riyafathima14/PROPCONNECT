import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/sellpage2.dart';

class SellPage1 extends StatefulWidget {
  const SellPage1({super.key});

  @override
  State<SellPage1> createState() => _SellPage1State();
}

class _SellPage1State extends State<SellPage1> {
  String? selectedLookingTo;
  String? selectedPropertyType;
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Add Basic Details",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Step 1 of 3",
              style: TextStyle(fontSize: 12, color: Color(0xff787171)),
            ),

            const SizedBox(height: 40),
            const Text(
              "You're looking to?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                choiceChip("Sell", selectedLookingTo, (value) {
                  setState(() {
                    selectedLookingTo = value;
                  });
                }),
                choiceChip("Rent/Lease", selectedLookingTo, (value) {
                  setState(() {
                    selectedLookingTo = value;
                  });
                }),
                choiceChip("Paying Guest", selectedLookingTo, (value) {
                  setState(() {
                    selectedLookingTo = value;
                  });
                }),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              "What kind of property?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 15,
              runSpacing: 10,
              children: [
                choiceChip("Apartment", selectedPropertyType, (value) {
                  setState(() {
                    selectedPropertyType = value;
                  });
                }),
                choiceChip("Independent House/Villa", selectedPropertyType, (
                  value,
                ) {
                  setState(() {
                    selectedPropertyType = value;
                  });
                }),
                choiceChip("Plot/Land", selectedPropertyType, (value) {
                  setState(() {
                    selectedPropertyType = value;
                  });
                }),
                choiceChip("Independent /Builder Floor", selectedPropertyType, (
                  value,
                ) {
                  setState(() {
                    selectedPropertyType = value;
                  });
                }),
              ],
            ),

            const SizedBox(height: 50),
            const Text(
              "Your contact details",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: "Phone number / Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffC4C4C4)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sellpage2()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF204ECF),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget choiceChip(
    String label,
    String? selectedValue,
    Function(String) onSelected,
  ) {
    final bool isSelected = label == selectedValue;
    return OutlinedButton(
      onPressed: () => onSelected(label),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,

        side: BorderSide(
          color: isSelected ? Color(0xFF204ECF) : Colors.grey.shade400,
        ),
        shape: const StadiumBorder(),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
