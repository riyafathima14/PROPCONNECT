import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:propconnect/services/property.dart';

class RecommendatioScreen extends StatefulWidget {
  const RecommendatioScreen({super.key});

  @override
  State<RecommendatioScreen> createState() => _RecommendatioScreenState();
}

class _RecommendatioScreenState extends State<RecommendatioScreen> {
  late Future<List<Property>> _futureProperties;
  @override
  void initState() {
    super.initState();
    _futureProperties = fetchTopRatedProperties(); // <-- only once
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 220,
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: (){
                  Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder:
                    (context, animation, secondaryAnimation) =>
                        const HomePage(),
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
                }
              ),
              Image.asset(
                'assets/images/logoblue.png',
                fit: BoxFit.contain,
                height: 14,
              ),
            ],
          ),
        ),

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth/17),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top-Rated Properties",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: screenWidth/17),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Discover the best properties curated just for you.",
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Property>>(
                future: _futureProperties,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No top-rated properties found.'),
                    );
                  } else if (snapshot.hasData) {
                    final properties = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        final property = properties[index];
                        return buildPropertyCard(property);
                      },
                    );
                  }
                  // If none of the above conditions match, throw an exception.
                  throw Exception(
                    'Unexpected snapshot state: ${snapshot.connectionState}',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPropertyCard(Property property) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top part: Property Image with Favorites Icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  property.imgURL.isNotEmpty
                      ? property.imgURL[0]
                      : 'https://via.placeholder.com/150',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Color(0xFF204ECF),
                  ),
                ),
              ),
            ],
          ),
          // Bottom part: Property Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property Title
                Text(
                  property.title,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                // Location and Price
                Text(
                  '${property.location} • ₹${property.price.toStringAsFixed(0)}',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                // Row with Rating and Interested Container
                Row(
                  children: [
                    // Rating Container
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF204ECF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${property.rating} ⭐',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Interested Container with WhatsApp and Phone Icons
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
