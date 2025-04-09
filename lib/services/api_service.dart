import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://8fa4-2403-a080-1004-a111-25e7-6fd0-448b-ba9b.ngrok-free.app'; // <-- Update if needed

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

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // If it's an error, return an error message safely
        return {
          'error': 'Failed to send OTP. Server responded with ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'error': 'Exception occurred: $e'
      };
    }
  }
}
