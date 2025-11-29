import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void showOtpResentSnackbar(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final mediaQuery = MediaQuery.of(context);
  final screenWidth = mediaQuery.size.width;

  Get.snackbar(
    "", // Empty to use custom titleText
    "", // Empty to use custom messageText
    backgroundColor: isDark ? Colors.grey[900]! : Colors.white,
    snackPosition: SnackPosition.TOP,
    borderRadius: 12,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    duration: const Duration(seconds: 4),
    boxShadows: const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    titleText: Row(
      children: [
        Lottie.asset(
          'assets/images/Order completed.json',
          height: 40,
          width: 40,
          repeat: false,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "OTP Sent!",
            style: GoogleFonts.openSans(
              fontSize: screenWidth < 360 ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    ),
    messageText: Padding(
      padding: const EdgeInsets.only(left: 48), // aligns with Lottie
      child: Text(
        "A new OTP has been sent to your phone.",
        style: GoogleFonts.openSans(
          fontSize: screenWidth < 360 ? 12 : 14,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    ),
  );
}
