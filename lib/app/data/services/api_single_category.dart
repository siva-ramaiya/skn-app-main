import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodapp/app/config/app_config.dart';

class ApiSingleCategory {
  static final String baseUrl = AppConfig.baseUrl;

  Future<Map<String, dynamic>?> fetchCategoryById(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/categories/$id"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return data['data']; 
        } else {
          print("API returned failure: ${data['status']}");
          return null;
        }
      } else {
        print("HTTP error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception while fetching category: $e");
      return null;
    }
  }
}
