import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/loginpage/views/loginpage_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/registerpage_controller.dart';

class RegisterpageView extends GetView<RegisterpageController> {
  const RegisterpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterpageController());
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/registerpage.jpg"),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Fill in your details to register',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.03,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Name Field
                    TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark
                            ? Colors.grey[900]?.withOpacity(0.8)
                            : Colors.grey[100]?.withOpacity(0.8),
                        hintText: 'Full Name',
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

                    // Email Field
                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark
                            ? Colors.grey[900]?.withOpacity(0.8)
                            : Colors.grey[100]?.withOpacity(0.8),
                        hintText: 'Email',
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

                    // Phone Field
                    TextField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark
                            ? Colors.grey[900]?.withOpacity(0.8)
                            : Colors.grey[100]?.withOpacity(0.8),
                        hintText: 'Phone Number',
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
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark
                              ? Colors.grey[900]?.withOpacity(0.8)
                              : Colors.grey[100]?.withOpacity(0.8),
                          hintText: 'Password',
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
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 13),

                    // Confirm Password Field
                    Obx(
                      () => TextField(
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark
                              ? Colors.grey[900]?.withOpacity(0.8)
                              : Colors.grey[100]?.withOpacity(0.8),
                          hintText: 'Confirm Password',
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
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              controller.toggleConfirmPasswordVisibility();
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25),

                    // Register Button
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: controller.isValid.value
                              ? controller.onRegister
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.isValid.value
                                ? Colors.pinkAccent
                                : Colors.pinkAccent.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.05),

                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                           
                              Get.to(() => LoginpageView());
                            },
                            child: Text(
                              "Login",
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
        ],
      ),
    );
  }
}
