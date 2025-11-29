import 'package:flutter/material.dart';
// import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
// import 'package:foodapp/widgets/AuthService%20.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../controllers/phonescreenpage_controller.dart';
// import 'package:lottie/lottie.dart';
// import '../../home/views/home_view.dart'; // adjust as needed

class PhonescreenpageView extends GetView<PhonescreenpageController> {
  PhonescreenpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhonescreenpageController());
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;
    // final authService = AuthService();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 👉 Background Image with opacity
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/phonescreenpng.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // 👉 Foreground Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.06,
                            vertical: size.height * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.05),
                              Text(
                                'Enter your mobile number',
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Please confirm your country code and\nenter your mobile number',
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.029,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              IntlPhoneField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: isDark
                                      ? Colors.grey[900]?.withOpacity(0.8)
                                      : Colors.grey[100]?.withOpacity(0.8),
                                  hintText: 'Mobile number',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pink.shade300,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pink.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),

                                  // 👉 Error text color force white
                                  errorStyle: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                        0.029, // Responsive
                                    fontWeight: FontWeight.w500,
                                  ),

                                  // 👉 Counter text (0/0) color force white
                                  counterStyle: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                        0.028, // Responsive
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                initialCountryCode: 'IN',
                                dropdownIcon: Icon(
                                  Icons.arrow_drop_down,
                                  color: theme.iconTheme.color,
                                ),
                                style: GoogleFonts.poppins(
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                                cursorColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                onChanged: (phone) {
                                  controller.phoneNumber.value =
                                      phone.completeNumber;
                                  controller.validatePhone(
                                    phone.completeNumber,
                                  );
                                },
                              ),
                              SizedBox(height: size.height * 0.04),
                              Obx(
                                () => SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: controller.isValid.value
                                        ? controller.onContinue
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: controller.isValid.value
                                          ? Colors.pinkAccent
                                          : Colors.pinkAccent.withOpacity(0.4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Get OTP',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.08),

                              // 👉 Biometric Button
                              // Center(
                              //   child: ElevatedButton(
                              //     onPressed: () async {
                              //       final isAuthenticated = await authService
                              //           .authenticateWithBiometrics();
                              //       final isDark = Get.isDarkMode;

                              //       if (isAuthenticated) {
                              //         Get.snackbar(
                              //           "Success",
                              //           "Authenticated!",
                              //           icon: Padding(
                              //             padding: const EdgeInsets.only(top: 4),
                              //             child: SizedBox(
                              //               height: size.height * 0.05,
                              //               width: size.width * 0.1,
                              //               child: Lottie.asset(
                              //                 'assets/images/fingerrorint.json',
                              //                 repeat: false,
                              //                 fit: BoxFit.contain,
                              //               ),
                              //             ),
                              //           ),
                              //           boxShadows: [
                              //             BoxShadow(
                              //               color: isDark
                              //                   ? Colors.white.withOpacity(0.2)
                              //                   : Colors.black.withOpacity(0.2),
                              //               blurRadius: 8,
                              //               offset: const Offset(0, 4),
                              //             ),
                              //           ],
                              //           backgroundColor: isDark
                              //               ? Colors.black
                              //               : Colors.white,
                              //           colorText: isDark
                              //               ? Colors.white
                              //               : Colors.black,
                              //           snackPosition: SnackPosition.TOP,
                              //           margin: EdgeInsets.all(size.width * 0.03),
                              //           borderRadius: 12,
                              //           duration: const Duration(seconds: 2),
                              //           titleText: Text(
                              //             "Success",
                              //             style: GoogleFonts.openSans(
                              //               fontSize: size.width * 0.04,
                              //               fontWeight: FontWeight.bold,
                              //               color: isDark
                              //                   ? Colors.white
                              //                   : Colors.black,
                              //             ),
                              //           ),
                              //           messageText: Text(
                              //             "Authenticated!",
                              //             style: GoogleFonts.openSans(
                              //               fontSize: size.width * 0.035,
                              //               color: isDark
                              //                   ? Colors.white70
                              //                   : Colors.black54,
                              //             ),
                              //           ),
                              //         );
                              //         Get.offAll(() => BottomnavigationbarView());
                              //       } else {
                              //         Get.snackbar(
                              //           "",
                              //           "Please try again",
                              //           icon: Padding(
                              //             padding: EdgeInsets.only(top: 4),
                              //             child: SizedBox(
                              //               height: size.height * 0.05,
                              //               width: size.width * 0.1,
                              //               child: Lottie.asset(
                              //                 'assets/images/warining.json',
                              //                 repeat: false,
                              //                 fit: BoxFit.contain,
                              //               ),
                              //             ),
                              //           ),
                              //           boxShadows: [
                              //             BoxShadow(
                              //               color: isDark
                              //                   ? Colors.white.withOpacity(0.2)
                              //                   : Colors.black.withOpacity(0.2),
                              //               blurRadius: 8,
                              //               offset: const Offset(0, 4),
                              //             ),
                              //           ],
                              //           backgroundColor: isDark
                              //               ? Colors.black
                              //               : Colors.white,
                              //           colorText: isDark
                              //               ? Colors.white
                              //               : Colors.black,
                              //           snackPosition: SnackPosition.TOP,
                              //           margin: EdgeInsets.all(size.width * 0.03),
                              //           borderRadius: 12,
                              //           duration: const Duration(seconds: 2),
                              //           titleText: Text(
                              //             "Authentication Failed",
                              //             style: GoogleFonts.openSans(
                              //               fontSize: size.width * 0.04,
                              //               fontWeight: FontWeight.bold,
                              //               color: isDark
                              //                   ? Colors.white
                              //                   : Colors.black,
                              //             ),
                              //           ),
                              //         );
                              //       }
                              //     },
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: Get.isDarkMode
                              //           ? Colors.grey[900]
                              //           : Colors.white,
                              //       shape: const CircleBorder(),
                              //       padding: const EdgeInsets.all(16),
                              //       elevation: 4,
                              //     ),
                              //     child: Icon(
                              //       Icons.fingerprint,
                              //       size: 30,
                              //       color: Get.isDarkMode
                              //           ? Colors.white
                              //           : Colors.black,
                              //     ),
                              //   ),
                              // ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
