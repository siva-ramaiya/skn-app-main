import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProfile {
  static const String baseUrl = "http://192.168.1.12:3000/";

  final String token = '06ebc0609ebf5ddcfa743d4df7feccdb86f8cbeb';

  Future<Map<String, dynamic>> fetchUserDetails() async {
    final url = Uri.parse('${baseUrl}access/user-detail');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized! Check your token.');
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }
}
