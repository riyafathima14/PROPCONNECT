import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:propconnect/models/property.dart';

class TopRatedServices {
  static Future<List<PropertyBasic>> fetchTopRatedProperties() async {
    final response = await http.get(
     Uri.parse('http://192.168.1.3:5000/properties/top-rated'),
    );
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((prop) => PropertyBasic.fromJson(prop)).toList();
    } else {
      throw Exception('Failed to load properties');
    }
  }
}
