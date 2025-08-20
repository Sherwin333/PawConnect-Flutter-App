import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ForgotPasswordService {
  static Future<Map<String, dynamic>> sendResetEmail(String email) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/forgot_password.php');

    try {
      final response = await http.post(
        url,
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Server error. Try again later.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }
}
