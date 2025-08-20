import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class LoginService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/login.php'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {
        'success': false,
        'message': 'Server error. Try again later.',
      };
    }
  }
}
