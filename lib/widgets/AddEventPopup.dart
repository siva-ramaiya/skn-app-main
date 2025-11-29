import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/Calendereventpage/controllers/calendereventpage_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AddEventPopup {
  static void show(CalendereventpageController controller) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController eventController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    final context = Get.context!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: isDark ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.15,
                      child: Lottie.asset(
                        'assets/images/Confetti.json',
                        fit: BoxFit.contain,
                        repeat: true,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // User name field
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.cardColor,
                        hintText: "Enter Your Name",
                        hintStyle: GoogleFonts.teko(
                          fontSize: screenWidth * 0.03,
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorStyle: GoogleFonts.teko(
                          color: Colors.red,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Name is required *";
                        }
                        return null;
                      },
                      style: GoogleFonts.teko(
                        fontSize: screenWidth * 0.04,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // Phone number field
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.cardColor,
                        hintText: "Enter Phone Number",
                        hintStyle: GoogleFonts.teko(
                          fontSize: screenWidth * 0.03,
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorStyle: GoogleFonts.teko(
                          color: Colors.red,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone number is required *";
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Enter valid 10-digit phone number *";
                        }
                        return null;
                      },
                      style: GoogleFonts.teko(
                        fontSize: screenWidth * 0.04,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // Event name field
                    TextFormField(
                      controller: eventController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.cardColor,
                        hintText: "Enter Event Name",
                        hintStyle: GoogleFonts.teko(
                          fontSize: screenWidth * 0.03,
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorStyle: GoogleFonts.teko(
                          color: Colors.red,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Event name is required *";
                        }
                        return null;
                      },
                      style: GoogleFonts.teko(
                        fontSize: screenWidth * 0.04,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    // Description field
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.cardColor,
                        hintText: "Event Description",
                        hintStyle: GoogleFonts.teko(
                          fontSize: screenWidth * 0.03,
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorStyle: GoogleFonts.teko(
                          color: Colors.red,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Event description is required *";
                        }
                        return null;
                      },
                      style: GoogleFonts.teko(
                        fontSize: screenWidth * 0.04,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Buttons row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Cancel button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? Colors.pink
                                : const Color.fromARGB(255, 247, 204, 78),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.015,
                            ),
                            elevation: 4,
                            shadowColor: Colors.black.withOpacity(0.3),
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.teko(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Add button
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.addEvent(
                                eventController.text,
                                descriptionController.text,
                                userNameController.text,
                                phoneController.text,
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? const Color.fromARGB(255, 248, 210, 97)
                                : Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.015,
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            "Add",
                            style: GoogleFonts.teko(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
