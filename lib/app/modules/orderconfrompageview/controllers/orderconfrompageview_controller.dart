import 'package:foodapp/app/data/services/ApiOrderDetails.dart';
import 'package:get/get.dart';

class OrderconfrompageviewController extends GetxController {
  var deliveryAddress = ''.obs;
  var deliveryTime = ''.obs;
  var cartItems = <dynamic>[].obs;
  var totalWithDiscount = 0.0.obs;

  final api = ApiOrderDetails();

  void setCartItems(List<dynamic> items, double total) {
    cartItems.value = items;
    totalWithDiscount.value = total;
  }

  Future<Map<String, dynamic>?> createOrderAndGetPayment({
    required String address,
    required List<dynamic> cartItems,
  }) async {
    try {
      final response = await api.placeOrder(
        address: address,
        deliveryTime: "",
        paymentMethod: "Online",
        cartItems: cartItems,
      );

      if (response['statusCode'] == 200) {
        return response['data']; // contains razorpay_order + key info
      } else {
        Get.snackbar("Error", response['message'] ?? "Order failed");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to create order: $e");
      return null;
    }
  }

  Future<void> placeOrder({required String paymentMethod}) async {
    if (cartItems.isEmpty) {
      throw Exception("Cart is empty");
    }
    final result = await api.placeOrder(
      address: deliveryAddress.value,
      deliveryTime: deliveryTime.value,
      paymentMethod: paymentMethod,
      cartItems: cartItems,
    );
    // Optionally, clear cart after order
    cartItems.clear();
    totalWithDiscount.value = 0.0;
    print("Order placed successfully: $result");
  }
}
