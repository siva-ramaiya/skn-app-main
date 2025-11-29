// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// class ApiOrders {
//   final String baseUrl = "http://192.168.1.1:3000"; // 🔥 replace with your backend IP
//   final storage = GetStorage();

//   Future<Map<String, dynamic>> placeOrder({
//     required String address,
//     required String paymentMethod,
//     required List<Map<String, dynamic>> items,
//   }) async {
//     final token = storage.read("token") ?? "";

//     final response = await http.post(
//       Uri.parse("$baseUrl/orders"),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Token $token",
//       },
//       body: jsonEncode({
//         "address": address,
//         "payment_method": paymentMethod,
//         "items": items,
//       }),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return jsonDecode(response.body);
//     } else {
//       return {
//         "status": "error",
//         "message": "Failed to place order. Please try again."
//       };
//     }
//   }
// }
