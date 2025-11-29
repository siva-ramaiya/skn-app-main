import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void showAddToCartPopup({
  required String title,
  required String image,
  required String totalPrice,
  required int quantity,
}) {
  final context = Get.context!;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final size = MediaQuery.of(context).size;
  final textScale = MediaQuery.of(context).textScaleFactor;

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isDark
              ? const Color.fromARGB(255, 230, 211, 136)!
              : const Color.fromARGB(255, 39, 39, 39)!,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/images/Order completed.json',
              width: size.width * 0.6,
              height: size.width * 0.3,
              repeat: false,
            ),
            SizedBox(height: size.height * 0.015),
           
            Text(
              "$title x$quantity",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 15 * textScale,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? Colors.grey[300]
                    : const Color.fromARGB(255, 36, 36, 36),
              ),
            ),

            SizedBox(height: size.height * 0.005),
            Text(
              "Total: $totalPrice",
              style: TextStyle(
                fontSize: 16 * textScale,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
