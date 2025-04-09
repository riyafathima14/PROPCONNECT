import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/property.dart';

class PropertyDetailService {
  static Future<PropertyDetails> fetchPropertyById(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.3:5000/properties/$id'));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return PropertyDetails.fromJson(jsonData);
    } else {
      throw Exception('Failed to load property');
    }
  }
}
