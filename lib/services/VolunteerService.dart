import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart'; // Ensure this file has ApiConstants.baseUrl

class VolunteerService {
  static Future<bool> sendVolunteerData({
    required String name,
    required String contact,
    required String email,
    required String gender,
    required String dob,
    required String address,
    required String profession,
    required String reason,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/add_volunteer.php'),
      body: {
        'name': name,
        'contact': contact,
        'email': email,
        'gender': gender,
        'date_of_birth': dob,
        'address': address,
        'profession': profession,
        'reason': reason,
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['success'] == true;
    } else {
      return false;
    }
  }
}
