import 'dart:convert';
import 'package:foodapp/app/config/app_config.dart';
import 'package:http/http.dart' as http;

class ApiLogout {
  static final String baseUrl = AppConfig.baseUrl;

  static Future<bool> logout(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/access/logout'),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          print('✅ Logout successful');
          return true;
        } else {
          print('❌ Logout failed: ${data['message']}');
          return false;
        }
      } else {
        print('⚠️ HTTP Error: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('🔥 Exception during logout: $e');
      return false;
    }
  }
}
