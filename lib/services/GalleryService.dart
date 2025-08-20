import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class GalleryService {
  static Future<List<Map<String, dynamic>>> fetchGallery() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/view_gallery.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load gallery data");
    }
  }
}
