import 'dart:convert';
import 'package:http/http.dart' as http;

class TrendsService {
  static Future<List<dynamic>> fetchTrendingProperties({String? city}) async {
    try {
      // Construct the URL with an optional city filter
      String url = 'http://192.168.1.3:5000/properties/trending';
      if (city != null && city.isNotEmpty) {
        url += '?city=${Uri.encodeComponent(city)}';
      }
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // Assuming backend sends a List of property objects
      } else {
        throw Exception('Failed to load trending properties');
      }
    } catch (e) {
      throw Exception('Error fetching trending properties: $e');
    }
  }
}
