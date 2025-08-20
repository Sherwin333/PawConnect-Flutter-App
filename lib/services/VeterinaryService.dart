import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class VeterinaryService {
  static Future<List<Map<String, dynamic>>> fetchVeterinary() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/get_veterinary.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load veterinary data');
    }
  }
}
