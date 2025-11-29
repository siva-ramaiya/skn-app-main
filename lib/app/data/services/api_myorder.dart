// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiMyOrder {
//   final String baseUrl = "http://192.168.1.1:3000";

//   Future<List<Map<String, String>>> getUserOrders(String token) async {
//     final url = Uri.parse("$baseUrl/orders");

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           "Authorization": "Token $token",
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         final body = json.decode(response.body);

//         if (body["status"] == "success" && body["data"] != null) {
//           List<Map<String, String>> orders = [];

//           for (var order in body["data"]) {
//             orders.add({
//               "id": order["id"].toString(),
//               "item": "Order #${order["id"]}", // You can customize
//               "shop": "Total: ₹${order["total_amount"]}",
//               "price": "₹${order["total_amount"]}",
//               "status": order["status"],
//             });
//           }

//           return orders;
//         } else {
//           return [];
//         }
//       } else {
//         print("Failed to load orders: ${response.statusCode}");
//         return [];
//       }
//     } catch (e) {
//       print("Error fetching orders: $e");
//       return [];
//     }
//   }
// }
