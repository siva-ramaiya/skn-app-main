// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// //api_cart_service.dart addcartpage
// class ApiCartService {
//   final String baseUrl = "http://192.168.1.1:3000"; // 🔥 Your backend IP
//   final storage = GetStorage();

//   // Get cart items
//   Future<List<Map<String, dynamic>>> getCartItems() async {
//     final token = storage.read('token') ?? '';
//     final response = await http.get(
//       Uri.parse('$baseUrl/cart'),
//       headers: {
//         'Authorization': 'Token $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       List<Map<String, dynamic>> items = [];

//       for (var item in data['data']) {
//         items.add({
//           'id': item['id'],
//           'item_id': item['item_id'],
//           'title': item['name'],
//           'unitPrice': item['price'].toString(),
//           'quantity': item['quantity'].toString(),
//           // API nundi image vachina use cheyadam, lekunte local placeholder
//           'image':
//               item['image_url'] != null &&
//                   item['image_url'].toString().isNotEmpty
//               ? item['image_url']
//               : 'assets/images/addtotot.png',
//         });
//       }

//       return items;
//     } else {
//       throw Exception('Failed to fetch cart items');
//     }
//   }

//   // Update quantity
//   Future<bool> updateQuantity(int itemId, int quantity) async {
//     final token = storage.read('token') ?? '';
//     final response = await http.put(
//       Uri.parse('$baseUrl/cart/$itemId'),
//       headers: {
//         'Authorization': 'Token $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({'quantity': quantity}),
//     );
//     return response.statusCode == 200;
//   }

//   // Remove item
//   Future<bool> removeItem(int itemId) async {
//     final token = storage.read('token') ?? '';
//     final response = await http.delete(
//       Uri.parse('$baseUrl/cart/$itemId'),
//       headers: {'Authorization': 'Token $token'},
//     );
//     return response.statusCode == 200;
//   }
// }
