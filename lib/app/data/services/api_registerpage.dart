import 'dart:convert';
import 'package:foodapp/app/config/app_config.dart';
import 'package:http/http.dart' as http;

class ApiRegisterpage {
  static final String baseUrl = AppConfig.baseUrl;
  
  // POST request
  static Future<http.Response> postRequest(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl/access/register');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  // GET request
  static Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(url);
  }
}
