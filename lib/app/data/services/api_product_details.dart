import 'dart:convert';
import 'package:foodapp/app/config/app_config.dart';
import 'package:http/http.dart' as http;

class ApiProductDetails {
  static final String baseUrl = AppConfig.baseUrl;


  /// Fetch products by category ID
  Future<List<Map<String, dynamic>>> fetchProductsByCategory(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/categories/$id/items"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return List<Map<String, dynamic>>.from(data['data']);
        } else {
          print("API returned failure: ${data['status']}");
          return [];
        }
      } else {
        print("HTTP error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception while fetching products: $e");
      return [];
    }
  }
}
