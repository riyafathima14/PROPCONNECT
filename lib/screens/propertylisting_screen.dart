import 'package:flutter/material.dart';

class PropertyListingScreen extends StatelessWidget {
  final List<dynamic> properties; // Accept the properties list

  const PropertyListingScreen({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
      ),
      body: properties.isEmpty
          ? const Center(child: Text('No properties found.'))
          : ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return ListTile(
                  title: Text(property['title'] ?? 'No Title'),
                  subtitle: Text(property['address'] ?? 'No Address'),
                  trailing: Text('₹${property['price'] ?? 'N/A'}'),
                );
              },
            ),
    );
  }
}
