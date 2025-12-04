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
      final url = "$baseUrl/categories/$categoryId/items";
      print('🌐 Fetching items from: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('📡 Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print('📦 Full response: ${jsonData}');
        
        // Debug: Print the keys in the response
        print('📋 Response keys: ${jsonData.keys.toList()}');
        
        // Check if 'data' exists and is a list
        if (jsonData['data'] != null && jsonData['data'] is List) {
          final items = jsonData['data'] as List<dynamic>;
          
          // Debug: Print the first item's structure if available
          if (items.isNotEmpty) {
            print('🔍 First item structure:');
            (items.first as Map<String, dynamic>).forEach((key, value) {
              print('   - $key: $value (${value.runtimeType})');
            });
          }
          
          print('✅ Found ${items.length} items for category $categoryId');
          return items;
        } else {
          print('⚠️ No items found or invalid data format for category $categoryId');
          print('⚠️ Response data type: ${jsonData['data']?.runtimeType}');
          return [];
        }
      } else {
        final errorMsg = 'Failed to load category items. Status: ${response.statusCode}, Body: ${response.body}';
        print('❌ $errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('❌ Error fetching category items: $e');
      rethrow; // Re-throw to allow proper error handling in the controller
    }
  }
}
