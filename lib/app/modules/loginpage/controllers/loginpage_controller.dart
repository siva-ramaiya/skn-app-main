import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:foodapp/app/utils/storage_helper.dart';
import 'package:foodapp/app/data/services/api_service.dart';
import 'package:foodapp/app/modules/home/views/home_view.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';

class LoginpageController extends GetxController {
  final passwordController = TextEditingController();
  final phoneNumber = ''.obs;
  final isPasswordVisible = false.obs;
  final isValid = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void validatePhone(String phone) {
    isValid.value = phone.isNotEmpty && passwordController.text.isNotEmpty;
  }

  Future<void> onLogin() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await ApiService.postRequest("/access/login", {
        "phone_number": phoneNumber.value,
        "password": passwordController.text,
      });

      Get.back(); // Close loader

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          final token = data['data']['token'];
          await StorageHelper.saveToken(token); // ✅ Save token
          await StorageHelper.saveUserData(data['data']['user']); // ✅ Save user data

          Get.snackbar(
            "Login Successful",
            "Welcome back!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // ✅ Navigate to home page after 1 second delay
          Future.delayed(const Duration(seconds: 1), () {
            Get.offAll(() => BottomnavigationbarView());
            // Get.offAll(() => HomeView());
            // Get.offAllNamed(Routes.HOME);
          });

          // Navigate to your next screen (e.g., HomePage)
          // Get.offAll(() => HomePageView());
        } else {
          Get.snackbar(
            "Login Failed",
            data['message'] ?? 'Invalid credentials',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Server returned ${response.statusCode}",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back(); // close loader
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
