import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodapp/app/modules/registerpage/views/registerpage_view.dart';
import 'package:foodapp/app/modules/phonescreenpage/views/phonescreenpage_view.dart';
import '../controllers/loginpage_controller.dart';

class LoginpageView extends GetView<LoginpageController> {
  const LoginpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginpageController());
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/phonescreenpng.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // Foreground Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                                'Login to your account',
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Enter your phone number and password',
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.03,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // ✅ Simple Phone Field (without country selector)
                              TextField(
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  controller.phoneNumber.value = value;
                                  controller.validatePhone(value);
                                },
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
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),

                              SizedBox(height: 13),

                              // Password Field
                              Obx(
                                () => TextField(
                                  controller: controller.passwordController,
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  onChanged: (_) {
                                    controller.validatePhone(
                                      controller.phoneNumber.value,
                                    );
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: isDark
                                        ? Colors.grey[900]?.withOpacity(0.8)
                                        : Colors.grey[100]?.withOpacity(0.8),
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: theme.textTheme.bodyLarge?.color,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed:
                                          controller.togglePasswordVisibility,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height * 0.01),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => PhonescreenpageView());
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: size.height * 0.04),

                              // Login Button
                              Obx(
                                () => SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: controller.isValid.value
                                        ? controller.onLogin
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
                                      'Login',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const Spacer(),

                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => RegisterpageView());
                                      },
                                      child: Text(
                                        "Register",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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