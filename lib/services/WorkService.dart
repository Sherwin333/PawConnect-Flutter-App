import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class WorkService {
  static Future<List<Map<String, dynamic>>> fetchWork() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/view_work.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load work posts');
    }
  }
}
