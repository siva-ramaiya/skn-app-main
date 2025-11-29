// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';

// class ApiFavoritesPage {
//   final String baseUrl = "http://192.168.1.1:3000"; 
//   final storage = GetStorage();

//   /// 🔹 Get all favorites for the logged-in user
//   Future<List<Map<String, dynamic>>> fetchFavorites() async {
//     final token = storage.read('token');
//     if (token == null) {
//       throw Exception("Token not found");
//     }

//     final response = await http.get(
//       Uri.parse("$baseUrl/favorites"),
//       headers: {
//         "Authorization": "Token $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       if (body["status"] == "success" && body["data"] != null) {
//         return List<Map<String, dynamic>>.from(body["data"]);
//       } else {
//         return [];
//       }
//     } else {
//       throw Exception("Failed to load favorites: ${response.statusCode}");
//     }
//   }

//   /// 🔹 Remove an item from favorites
//   Future<bool> removeFavorite(int itemId) async {
//     final token = storage.read('token');
//     if (token == null) {
//       throw Exception("Token not found");
//     }

//     final response = await http.delete(
//       Uri.parse("$baseUrl/favorites/$itemId"),
//       headers: {
//         "Authorization": "Token $token",
//       },
//     );

//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       return body["status"] == "success";
//     } else {
//       throw Exception("Failed to remove favorite: ${response.statusCode}");
//     }
//   }
// }
