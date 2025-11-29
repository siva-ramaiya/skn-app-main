import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodapp/app/utils/storage_helper.dart';
import 'package:foodapp/app/config/app_config.dart';

/// Add Item to Cart API Service Class 
class ApiCart {
  // ✅ Use your backend's local IP or domain name (e.g., http://192.168.x.x:3000)
  static final String baseUrl = AppConfig.baseUrl; // 🔹 Change to your backend IP

  Future<Map<String, dynamic>> addToCart({
    required int itemId,
    required int quantity,
  }) async {
    final token = StorageHelper.getToken();

    if (token == null) {
      return {
        'statusCode': 401,
        'status': 'error',
        'message': 'User not logged in',
      };
    }

    final url = Uri.parse('$baseUrl/cart');
    final headers = {
      'Content-Type': 'application/json',
      // ✅ Most Node.js JWT auths expect "Token <token>", not "Token <token>"
      'Authorization': 'Token $token',
    };

    final body = jsonEncode({
      'item_id': itemId,
      'quantity': quantity,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // ✅ Handle success response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'statusCode': response.statusCode,
          ...jsonDecode(response.body),
        };
      }

      // ❌ Error response
      return {
        'statusCode': response.statusCode,
        'status': 'error',
        'message': 'Failed to add item to cart',
        'response': response.body,
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'status': 'error',
        'message': 'Something went wrong: $e',
      };
    }
  }

  // Get cart items
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final token = StorageHelper.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/cart'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> items = [];

      for (var item in data['data']) {
        items.add({
          'id': item['id'],
          'item_id': item['item_id'],
          'title': item['name'],
          'unitPrice': item['price'].toString(),
          'quantity': item['quantity'].toString(),
          // API nundi image vachina use cheyadam, lekunte local placeholder
          'image':
              item['image_url'] != null &&
                  item['image_url'].toString().isNotEmpty
              ? item['image_url']
              : '',
        });
      }

      return items;
    } else {
      throw Exception('Failed to fetch cart items');
    }
  }

  // Update quantity
  Future<bool> updateQuantity(int itemId, int quantity) async {
    final token = StorageHelper.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/cart/$itemId'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'quantity': quantity}),
    );
    return response.statusCode == 200;
  }

  // Remove item
  Future<bool> removeItem(int itemId) async {
    final token = StorageHelper.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/cart/$itemId'),
      headers: {'Authorization': 'Token $token'},
    );
    return response.statusCode == 200;
  }

}
