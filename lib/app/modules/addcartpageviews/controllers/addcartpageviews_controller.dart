import 'package:flutter/material.dart';
import 'package:foodapp/app/data/services/api_cart.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AddcartpageviewsController extends GetxController {
  final RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;
  final RxDouble subTotal = 0.0.obs;
  final RxDouble discount = 0.0.obs;
  final RxDouble totalWithDiscount = 0.0.obs;

  TextEditingController discountController = TextEditingController();
  final ApiCart apiService = ApiCart();

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
    discountController.addListener(applyDiscount);
  }

  // Fetch cart items from API
  void fetchCartItems() async {
    try {
      final items = await apiService.getCartItems();
      cartItems.assignAll(items);
      calculateSubTotal();
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    }
  }

  void addItem(Map<String, dynamic> item) {
    cartItems.add(item);
    calculateSubTotal();
  }

  void removeItem(int index) async {
    print('Attempting to remove item at index:'+cartItems.toString());
    final itemId = cartItems[index]['id'];
    bool success = await apiService.removeItem(itemId);
    if (success) {
      cartItems.removeAt(index);
      calculateSubTotal();
    } else {
      Get.snackbar(
        'Error',
        'Failed to remove item',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: Lottie.asset(
          'assets/images/Error animation.json', // 🔹 Replace with your Lottie file path
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        borderRadius: 15,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }

  void increaseQuantity(int index) async {
    int quantity = int.tryParse(cartItems[index]['quantity'].toString()) ?? 1;
    quantity++;
    final itemId = cartItems[index]['id'];
    bool success = await apiService.updateQuantity(itemId, quantity);
    if (success) {
      cartItems[index]['quantity'] = quantity.toString();
      cartItems.refresh();
      calculateSubTotal();
    }
  }

  void decreaseQuantity(int index) async {
    int quantity = int.tryParse(cartItems[index]['quantity'].toString()) ?? 1;
    if (quantity > 1) {
      quantity--;
      final itemId = cartItems[index]['id'];
      bool success = await apiService.updateQuantity(itemId, quantity);
      if (success) {
        cartItems[index]['quantity'] = quantity.toString();
        cartItems.refresh();
        calculateSubTotal();
      }
    }
  }

  void calculateSubTotal() {
    double total = 0;
    for (var item in cartItems) {
      int price =
          int.tryParse(
            item['unitPrice'].toString().replaceAll(RegExp(r'[^\d]'), ''),
          ) ??
          0;
      int quantity = int.tryParse(item['quantity'].toString()) ?? 1;
      total += price * quantity;
    }
    subTotal.value = total;
    applyDiscount();
  }

  void applyDiscount() {
    final input = double.tryParse(discountController.text) ?? 0.0;
    discount.value = input.clamp(0, subTotal.value);
    totalWithDiscount.value = subTotal.value - discount.value;
  }

  int getTotal() => totalWithDiscount.value.toInt();
}
