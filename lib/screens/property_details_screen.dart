import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final String title = property['title'] ?? '';
    final String location = property['location'] ?? '';
    final double price = (property['price'] as num?)?.toDouble() ?? 0.0;
    final double rating = (property['rating'] as num?)?.toDouble() ?? 0.0;
    final List<dynamic> images = property['imgURL'] ?? [];
    final String description = property['description'] ?? 'No description available.';

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: GoogleFonts.nunito()),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (images.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(images[0], fit: BoxFit.cover),
              ),
            const SizedBox(height: 16),
            Text(title, style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(location, style: GoogleFonts.nunito(fontSize: 16)),
            const SizedBox(height: 8),
            Text('₹${price.toStringAsFixed(0)}', style: GoogleFonts.nunito(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 20),
                const SizedBox(width: 4),
                Text(rating.toString(), style: GoogleFonts.nunito(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Text('Description', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: GoogleFonts.nunito(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
