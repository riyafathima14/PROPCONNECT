import 'dart:convert';
import 'package:http/http.dart' as http;

class Property {
  final int id;
  final String title;
  final String location;
  final double price;
  final double rating;
  final List<String> imgURL;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.imgURL,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      imgURL: List<String>.from(json['imgURL']),
    );
  }
}

Future<List<Property>> fetchTopRatedProperties() async {
  final response = await http.get(Uri.parse('http://192.168.1.3:5000/properties/top-rated'));
print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((prop) => Property.fromJson(prop)).toList();
  } else {
    throw Exception('Failed to load properties');
  }
}
