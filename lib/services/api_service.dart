import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://172.16.12.20:5000'; // Change if needed

  static Future<Map<String, dynamic>> sendOtp({
    required String method,
    String? email,
    String? phone,
  }) async {
    final url = Uri.parse('$baseUrl/send-otp');

    final body = {
      'method': method,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }
}
