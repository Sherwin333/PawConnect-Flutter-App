import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../constants/constants.dart';

class RescueService {
  static Future<bool> sendRescueRequest(String userId, String description, File imageFile) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/rescue_request.php');

    final request = http.MultipartRequest('POST', uri)
      ..fields['uid'] = userId
      ..fields['description'] = description
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

    final response = await request.send();
    final responseData = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final result = json.decode(responseData.body);
      return result['success'] == true;
    } else {
      return false;
    }
  }
}
