import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class PetService {
  static Future<List<Map<String, dynamic>>> fetchPets() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/view_pets.php'));

    if (response.statusCode == 200) {
      final List<dynamic> pets = json.decode(response.body);
      return pets.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load pets');
    }
  }

  static Future<Map<String, dynamic>> adoptPet(String userId, String petId) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/adopt_request.php'),
      body: {
        'user_id': userId,
        'pet_id': petId,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send adopt request');
    }
  }
}
