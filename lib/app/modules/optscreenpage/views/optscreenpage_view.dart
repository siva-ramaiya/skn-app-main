import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../controllers/optscreenpage_controller.dart';

class OptscreenpageView extends GetView<OptscreenpageController> {
  const OptscreenpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OptscreenpageController());
    final media = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Responsive font scale
    double scaleFont(double size) => size * media.width * 0.0027;

    return Scaffold(
      body: Stack(
        children: [
          /// Background image with opacity
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/optscreennnnnn.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: media.width * 0.05,
                      top: media.height * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color.fromARGB(255, 243, 200, 73)
                          : Colors.pink,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: media.width * 0.05,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),

                /// Center section
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: media.width * 0.07,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// Title
                            Text(
                              'Phone Verification',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: scaleFont(19),
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: media.height * 0.015),

                            /// Subtitle
                            Text(
                              'Enter the OTP sent to your phone number',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: scaleFont(13),
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: media.height * 0.04),

                            /// OTP Input
                            Pinput(
                              length: 4,
                              controller: controller.otpController,
                              onChanged: (value) {
                                controller.isValid.value = value.length == 4;
                              },
                              defaultPinTheme: PinTheme(
                                width: media.width * 0.16,
                                height: media.width * 0.16,
                                textStyle: TextStyle(
                                  fontSize: scaleFont(22),
                                  fontWeight: FontWeight.bold,
                                  color: theme.textTheme.bodyLarge!.color,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(12),
                                  color: isDark ? Colors.grey[850] : Colors.grey[200],
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: media.width * 0.16,
                                height: media.width * 0.16,
                                textStyle: GoogleFonts.poppins(
                                  fontSize: scaleFont(22),
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: isDark ? Colors.grey[850] : Colors.grey[200],
                                ),
                              ),
                              onCompleted: (pin) {
                                controller.verifyOtp(pin);
                                controller.isValid.value = true;
                              },
                            ),

                            SizedBox(height: media.height * 0.03),

                            /// Countdown Timer
                            Obx(
                              () => Text(
                                'Code expires in 00:${controller.timer.value.toString().padLeft(2, '0')}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.secondary,
                                  fontSize: scaleFont(12),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(height: media.height * 0.03),

                            /// Resend OTP
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive the OTP? ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: scaleFont(12),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.resendCode,
                                  child: Text(
                                    'Resend OTP',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: isDark ? Colors.amber : Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: scaleFont(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: media.height * 0.05),

                            /// Verify Button
                            Obx(
                              () => SizedBox(
                                width: double.infinity,
                                height: media.height * 0.065,
                                child: ElevatedButton(
                                  onPressed: controller.isValid.value
                                      ? controller.onContinue
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: controller.isValid.value
                                        ? Colors.pink
                                        : const Color.fromARGB(255, 244, 203, 82),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Verify',
                                    style: GoogleFonts.poppins(
                                      fontSize: scaleFont(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: media.height * 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
