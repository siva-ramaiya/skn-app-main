import 'dart:convert';
import 'package:foodapp/app/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:foodapp/app/utils/storage_helper.dart';

class ApiFavorite {
  static final String baseUrl = AppConfig.baseUrl; // 🔹 Change to your backend IP
  final String token;

  ApiFavorite({required this.token});

  /// 🔹 Get all favorite products
  Future<List<Map<String, dynamic>>> fetchFavorites() async {
    try {
      final token = StorageHelper.getToken();
      final response = await http.get(
        Uri.parse("$baseUrl/favorites"),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return List<Map<String, dynamic>>.from(data['data']);
        }
      }
      return [];
    } catch (e) {
      print("❌ Exception fetching favorites: $e");
      return [];
    }
  }

  /// 🔹 Add product to favorites
  Future<bool> addToFavorites(int itemId) async {
    try {
      final token = StorageHelper.getToken();
      final response = await http.post(
        Uri.parse("$baseUrl/favorites"),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'item_id': itemId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          print("✅ Favorite added: ${data['data']}");
          return true;
        } else {
          print("⚠️ Failed to add favorite: ${data['message']}");
          return false;
        }
      } else {
        print("❌ HTTP Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Exception while adding favorite: $e");
      return false;
    }
  }

  /// 🔹 Remove product from favorites
  Future<bool> removeFromFavorites(int itemId) async {
    try {
      final token = StorageHelper.getToken();
      final response = await http.delete(
        Uri.parse("$baseUrl/favorites/$itemId"),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          print("✅ Favorite removed: ${data['data']}");
          return true;
        } else {
          print("⚠️ Failed to remove favorite: ${data['message']}");
          return false;
        }
      } else {
        print("❌ HTTP Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Exception while removing favorite: $e");
      return false;
    }
  }
}
