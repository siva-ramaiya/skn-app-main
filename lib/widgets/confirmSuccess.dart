import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';

/// ✅ Order Confirmed popup with buttons
void confirmSuccess(String orderId) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Get.isDarkMode ? const Color.fromARGB(255, 244, 228, 89) : Colors.pink,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final size = MediaQuery.of(context).size;
          final width = size.width;
          final height = size.height;

          return Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ✅ Success Animation
                Lottie.asset(
                  'assets/images/Feedback.json',
                  height: height * 0.18,
                  repeat: true,
                ),

                SizedBox(height: height * 0.02),

                // ✅ Title
                Text(
                  "Order Confirmed",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                SizedBox(height: height * 0.01),

                // ✅ Subtitle
                Text(
                  "Your order has been placed successfully!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.035,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),

                SizedBox(height: height * 0.03),

                // ✅ Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? const Color.fromARGB(255, 245, 202, 70) : Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: height * 0.018),
                        ),
                        onPressed: () {
                          Get.back();
                          // Handle "Next Order" action
                          // Get.offAll(() =>());
                        },
                        child: Text(
                          "Order",
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.white,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: isDark ? Colors.white : Colors.pink),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(vertical: height * 0.018),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            color: isDark ? Colors.white : Colors.pink,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
