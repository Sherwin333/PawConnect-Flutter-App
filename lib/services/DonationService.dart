import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class DonationService {
  static Future<bool> sendDonation(String userId, String amount, String description) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/add_donation.php'),
      body: {
        'userid': userId,
        'amount': amount,
        'description': description,
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
