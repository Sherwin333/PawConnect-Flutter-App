import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class VaccineService {
  static Future<List<Map<String, dynamic>>> fetchVaccines() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/view_vaccine.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load vaccine data');
    }
  }
}
