import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodapp/widgets/showOtpResentSnackbar.dart';
import 'package:get/get.dart';
import '../../bottomnavgationbar/views/bottomnavgationbar_view.dart';

class OptscreenpageController extends GetxController {
  final otpController = TextEditingController();
  final isDarkMode = Get.isDarkMode;
  final timer = 30.obs;
  final isValid = false.obs;
  Timer? countdown;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    countdown?.cancel();
    timer.value = 30;

    countdown = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value > 0) {
        timer.value--;
      } else {
        t.cancel();
      }
    });
  }

  void verifyOtp(String pin) {
    final context = Get.context!;
    final media = MediaQuery.of(context).size;

    if (pin == "1234") {
      showOtpResentSnackbar(context);
      otpController.clear();
      countdown?.cancel();
      Get.offAll(() => const BottomnavigationbarView());
    } else {
      Get.snackbar(
        "Error",
        "Invalid OTP",
        icon: Icon(
          Icons.error_outline,
          color: isDarkMode ? Colors.white : Colors.red,
        ),
        backgroundColor: isDarkMode ? Colors.grey[900]! : Colors.white,
        colorText: isDarkMode ? Colors.white : Colors.black,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.symmetric(
          horizontal: media.width * 0.04,
          vertical: media.height * 0.015,
        ),
        borderRadius: 12,
        padding: EdgeInsets.symmetric(
          horizontal: media.width * 0.04,
          vertical: media.height * 0.02,
        ),
        boxShadows: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        duration: const Duration(seconds: 3),
        isDismissible: true,
        shouldIconPulse: false,
      );
    }
  }

  void onContinue() {
    verifyOtp(otpController.text);
  }

  void resendCode() {
    otpController.clear();
    startTimer();
    Get.snackbar(
      "OTP",
      "A new OTP has been sent to your phone.",
      icon: Icon(
        Icons.sms_rounded,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      backgroundColor: isDarkMode ? Colors.grey[900]! : Colors.white,
      colorText: isDarkMode ? Colors.white : Colors.black,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      boxShadows: const [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
      ],
      padding: const EdgeInsets.all(16),
      isDismissible: true,
    );
  }

  @override
  void onClose() {
    countdown?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
