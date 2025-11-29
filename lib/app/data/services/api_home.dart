import 'dart:convert';
import 'package:foodapp/app/config/app_config.dart';
import 'package:http/http.dart' as http;

class ApiHome {
  static final String baseUrl = AppConfig.baseUrl;

  static Future<List<dynamic>> fetchItems() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/items"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
          return jsonData['data'];
        } else {
          return [];
        }
      } else {
        print("API Status Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("API Fetch Error: $e");
      return [];
    }
  }

  static Future<List<dynamic>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/categories"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // ✅ Correct key name: 'data'
        if (jsonData['data'] != null && jsonData['data'] is List) {
          return jsonData['data'] as List<dynamic>;
        } else {
          return [];
        }
      } else {
        throw Exception(
          "Failed to load categories. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  static Future<List<dynamic>> fetchCategoryItems(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/categories/$categoryId/items"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData['data'] != null && jsonData['data'] is List) {
          return jsonData['data'] as List<dynamic>; // ✅ Correct
        } else {
          return [];
        }
      } else {
        throw Exception(
          "Failed to load categories. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }
}
