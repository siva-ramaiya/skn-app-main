import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/app_config.dart';
import '../../utils/storage_helper.dart';

class ApiProfile {
  Future<Map<String, dynamic>> fetchUserDetails() async {
    try {
      final token = StorageHelper.getToken();
      
      if (token == null || token.isEmpty) {
        print('❌ No authentication token found');
        throw Exception("Authentication required. Please login again.");
      }

      // Ensure there's exactly one forward slash between base URL and endpoint
      final base = AppConfig.baseUrl.endsWith('/') 
          ? AppConfig.baseUrl.substring(0, AppConfig.baseUrl.length - 1) 
          : AppConfig.baseUrl;
      final endpoint = 'access/user-detail'.startsWith('/') 
          ? 'access/user-detail'.substring(1) 
          : 'access/user-detail';
          
      final url = Uri.parse('$base/$endpoint');
      print('🌐 API URL: $url');
      print('🔑 Using token: ${token.substring(0, 10)}...');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('🔄 Response status: ${response.statusCode}');
      print('📄 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData['status'] == 'success') {
          // Return the entire response so we can access status code and message if needed
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Failed to fetch user details');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Session expired. Please login again.');
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to load user data');
      }
    } catch (e) {
      print('❌ Error in fetchUserDetails: $e');
      rethrow; // Rethrow to be handled by the caller
    }
  }
}
