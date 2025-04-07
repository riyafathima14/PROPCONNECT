import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/screens/homepage.dart';
import 'package:propconnect/services/property.dart';
import 'package:propconnect/widgets/property_card_wiget.dart';
import 'package:provider/provider.dart'; //
import 'package:propconnect/providers/favorite_provider.dart'; // <-- Your new favorite provider

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
    _futureProperties =fetchTopRatedProperties(); // <-- only once
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
                onPressed: () {
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
                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
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
                padding: EdgeInsets.only(left: screenWidth / 17),
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
                padding: EdgeInsets.only(left: screenWidth / 17),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Discover the best properties curated just for you.",
                    style: GoogleFonts.nunito(fontSize: 14, color: Colors.grey),
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
                      physics:
                          const NeverScrollableScrollPhysics(), // because you already have SingleChildScrollView
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        final property = properties[index];

                        return Consumer<FavoriteProvider>(
                          builder: (context, favoriteProvider, child) {
                            final isFavorite = favoriteProvider.isFavorite(
                              property.id.toString(),
                            );

                            return buildPropertyCard(
                              property: property,
                              isFavorite: isFavorite,
                              onFavoriteToggle: () {
                                final favoriteProperty = FavoriteProperty(
                                  id: property.id.toString(),
                                  title: property.title,
                                  price: property.price,
                                  rating: property.rating,
                                  location: property.location,
                                  imgURL:
                                      property.imgURL.isNotEmpty
                                          ? property.imgURL[0]
                                          : '',
                                );

                                favoriteProvider.toggleFavorite(
                                  favoriteProperty,
                                );
                              },
                            );
                          },
                        );
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

  
}

