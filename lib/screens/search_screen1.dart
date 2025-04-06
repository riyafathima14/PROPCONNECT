import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:propconnect/services/search_services.dart';
import 'package:propconnect/screens/propertylisting_screen.dart';

class SearchScreen1 extends StatefulWidget {
  const SearchScreen1({super.key});

  @override
  State<SearchScreen1> createState() => _SearchScreen1State();
}

class _SearchScreen1State extends State<SearchScreen1> {
  bool isBuySelected = true; // true = Buy, false = Rent/PG

  String? selectedCity;
  String? selectedLocality;
  List<String> popularCities = [
    "Mumbai",
    "Bengaluru",
    "Chennai",
    "Kerala",
    "Delhi",
    "Kolkata",
    "Hyderabad",
    "Pune",
  ];

  Map<String, List<String>> popularLocalities = {
    "Mumbai": ["Andheri", "Bandra", "Dadar", "Thane"],
    "Bengaluru": ["Whitefield", "Indiranagar", "Koramangala", "Jayanagar"],
    "Chennai": ["T Nagar", "Velachery", "Anna Nagar", "Adyar"],
    "Kerala": [
      "Kochi",
      "Trivandrum",
      "Thrissur",
      "Kannur",
      "Kottayam",
      "Kozhikode",
      "Malappuram",
      "Alappuzha",
      "Edappally",
      "Kakkanad",
      "Pala",
    ],
    "Delhi": ["Connaught Place", "Karol Bagh", "Rohini", "Dwarka"],
    "Kolkata": ["Salt Lake", "Park Street", "Howrah", "Garia"],
    "Hyderabad": ["Gachibowli", "Banjara Hills", "Madhapur", "Begumpet"],
    "Pune": ["Koregaon Park", "Hinjewadi", "Kothrud", "Wakad"],
  };
  String? selectedPropertyType;
  String? minBudget;
  String? maxBudget;
  List<String> budgets = ["No Min", "₹5L", "₹10L", "₹20L", "₹50L", "₹1Cr"];
  List<String> maxBudgets = ["No Max", "₹10L", "₹20L", "₹50L", "₹1Cr", "₹5Cr"];

  List<Map<String, String>> propertyTypes = [
    {"name": "Flat/Apartment", "image": "assets/images/flat.png"},
    {"name": "House/Villa", "image": "assets/images/house.png"},
    {"name": "Plot/Land", "image": "assets/images/plot.png"},
  ];
  
  int parseBudgetInput(String input) {
    input = input.replaceAll(' ', '').toUpperCase(); // Clean spaces
    if (input.endsWith('L')) {
      int num = int.tryParse(input.replaceAll('L', '')) ?? 0;
      return num * 100000; // 1 Lakh = 100000
    } else if (input.endsWith('CR')) {
      int num = int.tryParse(input.replaceAll('CR', '')) ?? 0;
      return num * 10000000; // 1 Crore = 1 Crore = 10000000
    } else {
      // Assume plain number
      return int.tryParse(input) ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: screenSize.height * 0.20,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFF2451B7)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Toggle Buttons
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            _toggleButton("Buy", isSelected: isBuySelected),
                            _toggleButton(
                              "Rent/PG",
                              isSelected: !isBuySelected,
                            ),
                          ],
                        ),
                      ),
                      // Close Icon
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HomePage(),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                var fadeAnimation = Tween(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(animation);
                                return FadeTransition(
                                  opacity: fadeAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: screenSize.width * 0.07,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -screenSize.height * 0.035,
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.05,
                child: Container(
                  height: screenSize.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: screenSize.width * 0.06,
                      ),
                      SizedBox(width: screenSize.width * 0.03),
                      Text(
                        "Search",
                        style: GoogleFonts.nunito(
                          fontSize: screenSize.width * 0.04,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: screenSize.height * 0.07),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedCity == null) ...[
                  Text(
                    "Popular cities in India",
                    style: GoogleFonts.nunito(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Wrap(
                    spacing: screenSize.width * 0.02,
                    runSpacing: screenSize.height * 0.015,
                    children:
                        popularCities.map((city) => _cityButton(city)).toList(),
                  ),
                ] else ...[
                  // Selected City Pill
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (selectedCity != null)
                        Align(
                          alignment: Alignment.center,
                          child: _selectedCityPill(),
                        ),
                      if (selectedLocality != null) ...[
                        SizedBox(width: 8),
                        Align(
                          alignment: Alignment.center,
                          child: _selectedLocalityPill(),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: screenSize.height * 0.02),

                  if (selectedCity != null && selectedLocality == null) ...[
                    // Only show popular localities
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular localities in $selectedCity",
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          (popularLocalities[selectedCity!] ?? [])
                              .map(
                                (locality) =>
                                    _cityButton(locality, isLocality: true),
                              )
                              .toList(),
                    ),
                  ],

                  if (selectedCity != null && selectedLocality != null) ...[
                    // Budget dropdowns
                    Text(
                      "Budget in ₹",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// Budget Dropdowns
                    Row(
                      children: [
                        Expanded(
                          child: _budgetInput("No MIN", maxBudgets, (value) {
                            setState(() {
                              minBudget =
                                  parseBudgetInput(
                                    value,
                                  ).toString(); // 🚀 convert to number
                            });
                          }, minBudget?.toString()),
                        ),

                        const SizedBox(width: 10),
                        Text("To", style: GoogleFonts.nunito(fontSize: 16)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _budgetInput("No Max", maxBudgets, (value) {
                            setState(() {
                              maxBudget =
                                  parseBudgetInput(
                                    value,
                                  ).toString(); // 🚀 convert to number
                            });
                          }, maxBudget?.toString()),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Property Types Label
                    Text(
                      "Property types",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   

                    /// Property Type Selection
                    GridView.count(
  crossAxisCount: 3, // 3 cards per row (adjust if needed)
  // crossAxisSpacing:1,
  // mainAxisSpacing: 1,
  childAspectRatio: 1, // 👈 Important for equal width and height
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(), // Because inside a ScrollView
  children: propertyTypes.map((property) {
    return _propertyTypeCard(
      property['name']!,
      property['image']!,
      selectedPropertyType == property['name'], // Pass true/false if selected
    );
  }).toList(),
),

                  ],
                  //SizedBox(height: screenSize.height * 0.02),
                ],
              ],
            ),
          ),

          const Spacer(),

          // Bottom Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            height: screenSize.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCity = null;
                    selectedLocality = null;
                    isBuySelected = true;
                    });
                    
                  },
                  child: Text(
                    "Clear All",
                    style: GoogleFonts.nunito(
                      fontSize: screenSize.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2451B7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.015,
                    ),
                  ),
                  onPressed: () async {
  if (selectedCity != null && selectedLocality != null && selectedPropertyType != null) {
    print("Fetching properties...");
    final properties = await SearchService.searchProperties(
      city: selectedCity!,
      locality: selectedLocality!,
      minBudget: minBudget,
      maxBudget: maxBudget,
      propertyType: selectedPropertyType!,
      isBuy: isBuySelected,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyListingScreen(properties: properties),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select City, Locality and Property Type.")),
    );
  }
},

                  child: Row(
                    children: [
                      Text(
                        "Next",
                        style: GoogleFonts.nunito(
                          fontSize: screenSize.width * 0.04,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBuySelected = (text == "Buy");
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _cityButton(String name, {bool isLocality = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isLocality) {
            selectedLocality = name;
          } else {
            selectedCity = name;
            selectedLocality =
                null; // Reset locality when a new city is selected
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 16, color: Colors.black87),
            const SizedBox(width: 5),
            Text(
              name,
              style: GoogleFonts.nunito(fontSize: 14, color: Colors.black87),
            ),
            if ((isLocality && selectedLocality == name) ||
                (!isLocality && selectedCity == name))
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.check_circle, color: Colors.blue, size: 18),
              ),
          ],
        ),
      ),
    );
  }

  Widget _selectedCityPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$selectedCity",
            style: GoogleFonts.nunito(fontSize: 14, color: Colors.black),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => setState(() => selectedCity = null),
            child: const Icon(Icons.close, size: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _selectedLocalityPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$selectedLocality",
            style: GoogleFonts.nunito(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => setState(() => selectedLocality = null),
            child: const Icon(Icons.close, size: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _budgetInput(
    String hint,
    List<String> options,
    Function(String) onChanged,
    String? currentValue,
  ) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return options;
        }
        return options.where(
          (option) => option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },
      onSelected: (String selection) {
        onChanged(selection);
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextField(
          controller: fieldTextEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          keyboardType: TextInputType.text, // allow typing '10 L', '1 Cr'
          onChanged: (value) {
            onChanged(value);
          },
        );
      },
    );
  }

  /// Property Type Card Widget with Asset Images
  Widget _propertyTypeCard(String type, String imagePath, bool isSelected) {
     bool isSelected = selectedPropertyType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPropertyType = type; // Update on tap
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Color(0xFF204ECF) : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.contain),
              const SizedBox(height: 5),
              Text(
                type,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
