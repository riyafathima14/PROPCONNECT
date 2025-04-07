import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/property.dart'; // PropertyDetails model
import '../services/property_detail_service.dart'; // your PropertyDetailService

class PropertyDetailScreen extends StatefulWidget {
  final int propertyId;

  const PropertyDetailScreen({Key? key, required this.propertyId})
    : super(key: key);

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  late Future<PropertyDetails> propertyFuture;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String? _selectedFeedback;

  @override
  void initState() {
    super.initState();
    propertyFuture = PropertyDetailService.fetchPropertyById(widget.propertyId);
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder<PropertyDetails>(
        future: propertyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          }

          final property = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 1. Image Carousel
                buildImageCarousel(property.imgURL),

                // 🔹 2. Title
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    property.title,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // 🔹 3. Price
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        formatPrice(property.price),
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF204ECF)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Interested',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: Image.asset('assets/images/msg_icon.png'),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),

                const SizedBox(height: 10),

                // 🔹 4. Type + Status Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      buildInfoContainer(property.propertyType),
                      const SizedBox(width: 10),
                      buildInfoContainer(property.status),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 5. Size
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/sqft_img.png',
                        width: 25,
                        height: 25,
                      ),
                      Text(
                        '${property.size} sq. ft',
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔹 6. Description
                buildSectionTitle('Description'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    property.description,
                    style: GoogleFonts.nunito(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),

                // 🔹 7. Location
                buildSectionTitle('Location'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    property.location,
                    style: GoogleFonts.nunito(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 8. Google Map (showing actual location)
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(property.latitude!, property.longitude!),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('propertyLocation'),
                          position: LatLng(
                            property.latitude!,
                            property.longitude!,
                          ),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) {},
                    ),
                  ),
                ),

                // 🔹 9. Owner Details
                buildSectionTitle('Get Owner Details'),

                // 🔹 10. Owner Name + Contact
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // white background
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          MainAxisAlignment.center, // size to fit content
                      children: [
                        // 🔸 Profile Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            40,
                          ), // make it circular
                          child: Image.asset(
                            'assets/images/profile_img.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // 🔸 Owner Name and Contact
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property.ownerName,
                              style: GoogleFonts.nunito(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),

                            Text(
                              property.ownerContact,
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF204ECF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔹 11. Rating Stars
                buildRatingStars(property.rating),

                const SizedBox(height: 20),

                buildFeedbackSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget to build Image Carousel
  Widget buildImageCarousel(List<String> images) {
    if (images.isEmpty) {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: const Center(child: Text('No Images')),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(images[index], fit: BoxFit.cover);
            },
          ),
        ),
        const SizedBox(height: 8),
        // Row of indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 8 : 5,
              height: _currentPage == index ? 8 : 4,
              decoration: BoxDecoration(
                color: _currentPage == index ? Color(0xFF204ECF) : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }

  // Widget for Info Containers
  Widget buildInfoContainer(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFC4C4C4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: GoogleFonts.nunito(color: Colors.black)),
    );
  }

  // Widget for Section Titles
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildRatingStars(double? rating) {
    double displayRating = rating ?? 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Text(
                        displayRating.toStringAsFixed(1),
                        style: GoogleFonts.nunito(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "/5",
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Average Rating",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 15),

              // Right side: Rating image
              Image.asset(
                'assets/images/rating.png',
                height: 90,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFeedbackSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F1FA),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Are you finding us helpful?",
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Your feedback will help us make PropConnect the best",
              style: GoogleFonts.nunito(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFeedbackOption(
                  "assets/images/feedback_img1.png",
                  "Yes,Loving it",
                ),
                buildFeedbackOption(
                  "assets/images/feedback_img2.png",
                  "Average",
                ),
                buildFeedbackOption(
                  "assets/images/feedback_img3.png",
                  "No,Not really",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeedbackOption(String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFeedback = label;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Feedback submitted: $label'),
            duration: const Duration(seconds: 2),
          ),
        );

        // You can also call an API here or save it locally.
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    _selectedFeedback == label
                        ? const Color(0xFF204ECF)
                        : Colors.transparent,
                width: 2,
              ),
            ),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.nunito(
              color: Color(0xFF204ECF),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Format price in Cr or L
  String formatPrice(double price) {
    if (price >= 10000000) {
      return '₹ ${(price / 10000000).toStringAsFixed(2)} Cr';
    } else {
      return '₹ ${(price / 100000).toStringAsFixed(2)} L';
    }
  }
}
