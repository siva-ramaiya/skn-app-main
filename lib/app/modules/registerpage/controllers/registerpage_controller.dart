import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/app/data/services/api_registerpage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:foodapp/app/modules/loginpage/views/loginpage_view.dart';
import 'package:foodapp/app/data/services/api_service.dart'; // ✅ Import your ApiService

class RegisterpageController extends GetxController {
  // Text Controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  // Reactive States
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;
  var isValid = false.obs;

  // Toggle visibility
  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  // Validate all fields
  void validateFields() {
    isValid.value =
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  // Register API call
  Future<void> onRegister() async {
    validateFields();

    if (!isValid.value) {
      _showErrorSnackbar(
        "Please fill all fields correctly ❌\nCheck your inputs and try again.",
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiRegisterpage.postRequest("/access/register", {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "name": nameController.text.trim(),
        "phone_number": phoneController.text.trim(),
      });

      final data = jsonDecode(response.body);
      isLoading.value = false;

      if (response.statusCode == 200 && data["status"] == "success") {
        _showSuccessSnackbar(
          "User Registered Successfully ✅\nYou can now login to continue.",
        );
        await Future.delayed(Duration(seconds: 2));
        Get.offAll(() => LoginpageView());
      } else {
        _showErrorSnackbar(data["message"] ?? "Registration failed ❌");
      }
    } catch (e) {
      isLoading.value = false;
      _showErrorSnackbar("Something went wrong: $e");
    }
  }

  // ✅ Success Snackbar
  void _showSuccessSnackbar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          "Success",
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 209, 207, 207),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        messageText: Row(
          children: [
            Lottie.asset('assets/images/Success.json', width: 40, height: 40),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ✅ Error Snackbar
  void _showErrorSnackbar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          "Error",
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 212, 210, 210),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        messageText: Row(
          children: [
            Lottie.asset('assets/images/Error.json', width: 40, height: 40),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(validateFields);
    emailController.addListener(validateFields);
    phoneController.addListener(validateFields);
    passwordController.addListener(validateFields);
    confirmPasswordController.addListener(validateFields);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
