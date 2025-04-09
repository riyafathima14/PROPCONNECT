import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  static Future<List<dynamic>> searchProperties({
    
    required String locality,
    String? minBudget,
    String? maxBudget,
    List<String>? propertyTypes,
    required bool isBuy, // 🔥 Added isBuy
  }) async {
    try {
      final uri = Uri.parse('https://8fa4-2403-a080-1004-a111-25e7-6fd0-448b-ba9b.ngrok-free.app/properties/search_properties');

      Map<String, dynamic> body = {
        'location': locality,
        'is_buy': isBuy, // 🔥 Added is_buy field
      };

      // Add budget only if selected
      if (minBudget != null && minBudget.isNotEmpty) {
        body['min_budget'] = minBudget;
      }
      if (maxBudget != null && maxBudget.isNotEmpty) {
        body['max_budget'] = maxBudget;
      }

      // Add property type if selected
      if (propertyTypes != null && propertyTypes.isNotEmpty) {
  body['property_types'] = propertyTypes;  
}


      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['properties'] ?? []; // Assuming backend sends {"properties": [...]}
      } else {
        throw Exception('Failed to fetch properties');
      }
    } catch (e) {
      throw Exception('Error fetching properties: $e');
    }
  }
}
