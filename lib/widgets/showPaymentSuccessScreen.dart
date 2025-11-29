import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:foodapp/app/modules/trackingpage/views/trackingpage_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

void handlePaymentSuccess(String paymentId, List cartItems) {
  showPaymentSuccessScreen(paymentId, cartItems);
}

void showPaymentSuccessScreen(String paymentId, List cartItems) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Get.isDarkMode ? Colors.yellow : Colors.pink),
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
                  "Your Payment was successful!",
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
                  "You will get a response within a few minutes.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.035,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),

                SizedBox(height: height * 0.03),

                // ✅ Track Order Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? const Color.fromARGB(255, 243, 204, 90)
                          : Colors.pink,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isDark ? Colors.black : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: height * 0.018),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.to(
                        () => TrackingpageView(),
                        arguments: {'cartItems': cartItems},
                      );
                    },
                    child: Text(
                      "Track Order",
                      style: GoogleFonts.poppins(
                        color: isDark ? Colors.white : Colors.white,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.015),

                // ✅ Back to Home
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.offAll(() => BottomnavigationbarView());
                  },
                  child: Text(
                    "Back to Home",
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.035,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
