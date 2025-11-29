import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodapp/app/config/app_config.dart';
import 'package:foodapp/app/utils/storage_helper.dart';

/// 📦 Order API Service Class
class ApiOrderDetails {
  static final String baseUrl = AppConfig.baseUrl;

  // ==========================
  // Place a new order
  // ==========================
  Future<Map<String, dynamic>> placeOrder({
    required String address,
    required String deliveryTime,
    required String paymentMethod,
    required List<dynamic> cartItems,
  }) async {
    final token = StorageHelper.getToken();

    if (token == null) {
      return {
        'statusCode': 401,
        'status': 'error',
        'message': 'User not logged in',
      };
    }

    final url = Uri.parse('$baseUrl/orders');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };

    final body = jsonEncode({
      'address': address,
      'delivery_time': deliveryTime,
      'payment_method': paymentMethod,
      'items': cartItems.map((item) {
        return {
          'item_id': item['item_id'] ?? 0,
          'quantity': item['quantity'],
          'price': item['price'] ?? item['unitPrice'],
        };
      }).toList(),
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'statusCode': response.statusCode,
          ...jsonDecode(response.body),
        };
      }

      return {
        'statusCode': response.statusCode,
        'status': 'error',
        'message': 'Failed to place order',
        'response': response.body,
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'status': 'error',
        'message': 'Error placing order: $e',
      };
    }
  }

  // ==========================
  // Get order details by ID
  // ==========================
  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    final token = StorageHelper.getToken();

    if (token == null) {
      throw Exception('User not logged in');
    }

    final url = Uri.parse('$baseUrl/orders/$orderId');
    final headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['order'];
      } else {
        throw Exception('Failed to fetch order details: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching order details: $e');
    }
  }

  /// GET ALL ORDERS FOR LOGGED-IN USER
  Future<List<dynamic>> getUserOrders() async {
    final token = StorageHelper.getToken();

    if (token == null) {
      throw Exception('User not logged in');
    }

    final url = Uri.parse('$baseUrl/orders/user/history');
    final headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']; // List<dynamic>
      } else {
        throw Exception('Failed to fetch orders: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  /// GET ALL ORDERS FOR LOGGED-IN USER
  Future<List<dynamic>> getActiveOrders() async {
    final token = StorageHelper.getToken();

    if (token == null) {
      throw Exception('User not logged in');
    }

    final url = Uri.parse('$baseUrl/orders/user/active');
    final headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']; // List<dynamic>
      } else {
        throw Exception('Failed to fetch orders: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  // ==========================
  // 🧾 Record payment result to backend
  // ==========================
  Future<void> recordPaymentToBackend({
    required String transactionId,
    required String razorpayOrderId,
    required String status,
    required int orderId,
    required double amount,
  }) async {
    try {
      final token = StorageHelper.getToken();
      final response = await http.post(
        Uri.parse("${AppConfig.baseUrl}/payment"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode({
          "order_id": orderId,
          "amount": amount ?? 0, // you can pass real amount if available
          "payment_method": "Online",
          "transaction_id": transactionId,
          "razorpay_order_id": razorpayOrderId,
          "payment_status": status,
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Payment recorded successfully.");
      } else {
        print("⚠️ Failed to record payment: ${response.body}");
      }
    } catch (e) {
      print("❌ Error saving payment: $e");
    }
  }

  // ==========================
  // 🔁 Update Order status in backend
  // ==========================
  Future<void> updateOrderStatus({
    required int orderId,
    required String status,
    required String paymentStatus,
  }) async {
    try {
      final token = StorageHelper.getToken();
      final response = await http.put(
        Uri.parse("${AppConfig.baseUrl}/orders/$orderId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode({"status": status, "payment_status": paymentStatus}),
      );

      if (response.statusCode == 200) {
        print("✅ Order status updated successfully.");
      } else {
        print("⚠️ Failed to update order status: ${response.body}");
      }
    } catch (e) {
      print("❌ Error updating order status: $e");
    }
  }
}
