import 'package:flutter/material.dart';
import 'package:propconnect/screens/sellpage3.dart';

class Sellpage2 extends StatefulWidget {
  const Sellpage2({Key? key}) : super(key: key);

  @override
  State<Sellpage2> createState() => _Sellpage2State();
}

class _Sellpage2State extends State<Sellpage2> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar
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

      // Body
      body: SingleChildScrollView(
        // SingleChildScrollView allows the entire Column to scroll
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const SizedBox(height: 20),
              const Text(
                "Add Property Details",
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

              // Where is your property located?
              const Text(
                "Where is your property located?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "City",
                  labelStyle: TextStyle(
                    color: Color(0xff787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Locality",
                  labelStyle: TextStyle(
                    color: Color(0xff787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Add Room Details
              const Text(
                "Add Room Details",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "No. of Bedrooms",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              ChoiceChipGroup(
                options: ["1", "2", "3", "4", "5+"],
                onSelected: (value) {},
              ),

              const SizedBox(height: 35),
              const Text(
                "No. of Bathrooms",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ChoiceChipGroup(
                options: ["1", "2", "3", "4", "5+"],
                onSelected: (value) {},
              ),

              const SizedBox(height: 35),
              const Text(
                "Balconies",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ChoiceChipGroup(
                options: ["1", "2", "3", "More than 3"],
                onSelected: (value) {},
              ),
              const SizedBox(height: 40),

              // Add Area Details
              const Text(
                "Add Area Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text(
                "Atleast one area type is mandatory",
                style: TextStyle(
                  fontSize: 12,

                  color: Color(0xff787171),
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: "Carpet Area (sq.ft.)",
                  labelStyle: TextStyle(
                    color: Color(0xff787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Built-up Area (sq.ft.)",
                  labelStyle: TextStyle(
                    color: Color(0xff787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Floor Details
              const Text(
                "Floor Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text(
                "Total no of floors and your floor details",
                style: TextStyle(
                  fontSize: 12,

                  color: Color(0xff787171),
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Floor number",
                  labelStyle: TextStyle(
                    color: Color(0xff787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Total Floors",
                  labelStyle: TextStyle(
                    color: Color(0xff787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Availability Status
              const Text(
                "Availability Status",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ChoiceChipGroup(
                options: ["Ready to move", "Under construction"],
                onSelected: (value) {},
              ),
              const SizedBox(height: 40),

              // Furnishing (Optional)
              const Text(
                "Furnishing (Optional)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ChoiceChipGroup(
                options: ["Semi-furnished", "Furnished", "Unfurnished"],
                onSelected: (value) {
                  print("Furnishing: $value");
                },
              ),
              const SizedBox(height: 40),

              // Ownership
              const Text(
                "Ownership",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ChoiceChipGroup(
                options: ["Freehold", "Leasehold"],
                onSelected: (value) {},
              ),

              const SizedBox(height: 40),

              // Price Details
              const Text(
                "Price Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "Expected Price",
                  labelStyle: TextStyle(
                    color: Color(0xff787171),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: Color(0xffc4c4c4)),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // What makes your property unique
              const Text(
                "What makes your property unique",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Adding description will increase your listing visibility",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff787171),
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                maxLines: 4,
                style: TextStyle(
                  color: Color(0xff787171),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  hintText: "Share some details about your property",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: Color(0xffc4c4c4)),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Post and Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sellpage3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF204ECF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Post and Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              // Extra spacing at bottom
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceChipGroup extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelected;
  final String? initialValue;

  const ChoiceChipGroup({
    Key? key,
    required this.options,
    required this.onSelected,
    this.initialValue,
  }) : super(key: key);

  @override
  _ChoiceChipGroupState createState() => _ChoiceChipGroupState();
}

class _ChoiceChipGroupState extends State<ChoiceChipGroup> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          widget.options.map((option) {
            final isSelected = selected == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (value) {
                setState(() {
                  selected = option;
                });
                widget.onSelected(option);
              },
              selectedColor: Colors.white,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: isSelected ? const Color(0xFF204ECF) : Colors.grey,
              ),
              labelStyle: TextStyle(
                color: isSelected ? const Color(0xFF204ECF) : Colors.black,
              ),
              shape: const StadiumBorder(),
            );
          }).toList(),
    );
  }
}
