import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutpageController extends GetxController {
  late TapGestureRecognizer emailRecognizer;
  late TapGestureRecognizer phoneRecognizer;

  @override
  void onInit() {
    super.onInit();
emailRecognizer = TapGestureRecognizer()
  ..onTap = () async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'Sathishkumar18@gmail.com',
      queryParameters: {
        'subject': 'Customer Support Inquiry',
        'body': 'Hi Sathish,\n\nI have a question about your food app...',
      },
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        Get.snackbar(
          "Email App Not Found",
          "Please manually send email to Sathishkumar18@gmail.com",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.isDarkMode ? const Color(0xFFB00020) : const Color(0xFFD32F2F),
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error Occurred",
        "Unable to open email app.\nError: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? const Color(0xFFB00020) : const Color(0xFFD32F2F),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
      );
    }
  };

    phoneRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        final Uri phoneLaunchUri = Uri(scheme: 'tel', path: '9345131081');
        try {
          if (await canLaunchUrl(phoneLaunchUri)) {
            await launchUrl(phoneLaunchUri);
          } else {
            Get.snackbar(
              "Call Not Supported",
              "No dialer app found. Please call manually to 9345131081",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Get.isDarkMode ? const Color(0xFFB00020) : const Color(0xFFD32F2F),
              colorText: Get.isDarkMode ? Colors.white : Colors.white,
            );
          }
        } catch (e) {
          Get.snackbar(
            "Error",
            "Something went wrong: $e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.isDarkMode ? const Color(0xFFB00020) : const Color(0xFFD32F2F),
            colorText: Get.isDarkMode ? Colors.white : Colors.white,
          );
        }
      };
  }

  @override
  void onClose() {
    emailRecognizer.dispose();
    phoneRecognizer.dispose();
    super.onClose();
  }
}
