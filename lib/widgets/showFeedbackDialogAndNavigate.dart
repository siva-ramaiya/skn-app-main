import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void showFeedbackDialogAndNavigate() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/images/comment.json',
              width: 170,
              height: 160,
              repeat: false,
            ),
            const SizedBox(height: 16),

            /// Caption with MediaQuery responsive
            Builder(
              builder: (context) {
                double textScale = MediaQuery.of(context).size.width * 0.0045;
                bool isDark = Theme.of(context).brightness == Brightness.dark;

                return Column(
                  children: [
                    Text(
                      "Thank you for your order!",
                      style: GoogleFonts.poppins(
                        fontSize:8 * textScale,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  Future.delayed(const Duration(seconds: 3), () {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    Get.off(() => BottomnavigationbarView());
  });
}
