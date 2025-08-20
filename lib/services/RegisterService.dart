// services/RegisterService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class RegisterService {
  static Future<Map<String, dynamic>> register(
      String name, String email, String contact, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/register.php'),
      body: {
        'name': name,
        'email': email,
        'contact': contact,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // must return a Map
    } else {
      return {
        'success': false,
        'message': 'Server error: ${response.statusCode}',
      };
    }
  }
}
