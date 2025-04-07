import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propconnect/providers/favorite_provider.dart';
import 'package:propconnect/screens/property_details_screen.dart';
import 'package:propconnect/models/property.dart' as model;
import 'package:propconnect/widgets/property_card_wiget.dart';
import 'package:provider/provider.dart';

class PropertyListingScreen extends StatelessWidget {
  final List<dynamic> properties; // Expecting a list of property JSON objects

  const PropertyListingScreen({super.key, required this.properties});

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
      body:
          properties.isEmpty
              ? Center(
                child: Text(
                  'No properties found.',
                  style: GoogleFonts.nunito(fontSize: 12),
                ),
              )
              : ListView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // because you already have SingleChildScrollView
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final propertyJson = properties[index];

                  final model.PropertyBasic property = model.PropertyBasic.fromJson(
                    propertyJson,
                  );

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
              ),
    );
  }
}
