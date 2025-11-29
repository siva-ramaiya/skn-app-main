import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodapp/app/config/app_config.dart';
import 'package:foodapp/app/utils/storage_helper.dart';

class ApiService {
  static final String baseUrl = AppConfig.baseUrl;

  static Future<http.Response> postRequest(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = StorageHelper.getToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Token $token', // Add token if available
    };

    final url = Uri.parse('$baseUrl$endpoint');
    print('Url-----${url}');
    print('Response-----${body}');
    return await http.post(url, headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> getRequest(String endpoint) async {
    final token = StorageHelper.getToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Token $token',
    };

    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(url, headers: headers);
  }
}
