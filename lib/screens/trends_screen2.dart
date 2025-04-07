import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/providers/favorite_provider.dart';
import 'package:propconnect/screens/property_details_screen.dart';
import 'package:propconnect/models/property.dart';
import 'package:propconnect/widgets/property_card_wiget.dart';
import 'package:provider/provider.dart';
import '../services/trends_service.dart';

class TrendsScreen2 extends StatefulWidget {
  final String cityName;
  const TrendsScreen2({super.key, required this.cityName});

  @override
  State<TrendsScreen2> createState() => _TrendsScreen2State();
}

class _TrendsScreen2State extends State<TrendsScreen2> {
  late Future<List<dynamic>> _trendingProperties;

  @override
  void initState() {
    super.initState();
    // Call the API with the selected city name.
    _trendingProperties = TrendsService.fetchTrendingProperties(
      city: widget.cityName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trending in ${widget.cityName}',
          style: GoogleFonts.nunito(),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<dynamic>>(
              future: _trendingProperties,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Loading spinner while data is fetched.
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Display an error message if something went wrong.
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: GoogleFonts.nunito(),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // No properties found.
                  return Center(
                    child: Text(
                      'No trending properties found in ${widget.cityName}.',
                      style: GoogleFonts.nunito(fontSize: 16),
                    ),
                  );
                } else {
                  // Data fetched successfully.
                  final List<dynamic> properties = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // because you already have SingleChildScrollView
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = PropertyBasic.fromJson(properties[index]);
                      return Consumer<FavoriteProvider>(
                        builder: (context, favoriteProvider, child) {
                          final isFavorite = favoriteProvider.isFavorite(
                            property.id.toString(),
                          );
            
                          return GestureDetector(
                             onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PropertyDetailScreen(
                                          propertyId: property.id,
                                        ),
                                  ),
                                );
                              },
                            child: buildPropertyCard(
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
                                        
                                favoriteProvider.toggleFavorite(favoriteProperty);
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
