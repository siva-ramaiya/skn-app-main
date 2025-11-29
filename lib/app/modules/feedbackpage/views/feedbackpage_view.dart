import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:foodapp/widgets/showFeedbackDialogAndNavigate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodapp/app/modules/feedbackpage/controllers/feedbackpage_controller.dart';

class FeedbackpageView extends StatelessWidget {
  FeedbackpageView({Key? key}) : super(key: key);

  static const List<String> stars = ['😞', '😕', '😐', '🙂', '😃'];

  final FeedbackpageController controller = Get.put(FeedbackpageController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    /// Responsive scaling factor (base width = 375)
    double scaleFactor = (width / 375).clamp(0.8, 1.4);

    /// Max content width for large screens (tablet/web)
    double maxWidth = width > 900
        ? 700
        : width > 600
            ? 520
            : width * 0.92;

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface;
    final cardColor = theme.cardColor;
    final brightness = theme.brightness;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 36 * scaleFactor,
              horizontal: 16 * scaleFactor,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 28 * scaleFactor,
                  horizontal: 24 * scaleFactor,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16 * scaleFactor),
                  border: Border.all(
                    color: (brightness == Brightness.dark
                            ? const Color.fromARGB(255, 242, 198, 65)
                            : Colors.pink)
                        .withOpacity(0.7),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: brightness == Brightness.light
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.black45,
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Close Button
                    Align(
                      alignment: Alignment.topRight,
                      child: InkResponse(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(24 * scaleFactor),
                        radius: 24 * scaleFactor,
                        child: Container(
                          padding: EdgeInsets.all(6 * scaleFactor),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (brightness == Brightness.dark
                                    ? const Color.fromARGB(255, 242, 198, 65)
                                    : Colors.pink)
                                .withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            size: 26 * scaleFactor,
                            color: brightness == Brightness.dark
                                ? const Color.fromARGB(255, 242, 198, 65)
                                : Colors.pink,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6 * scaleFactor),

                    /// Title
                    Text(
                      'Give Feedback',
                      style: GoogleFonts.poppins(
                        textStyle: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize:18 * scaleFactor,
                          color: onSurface,
                        ),
                      ),
                    ),
                    SizedBox(height: 6 * scaleFactor),

                    /// Subtitle
                    Text(
                      'What do you think of the editing tool?',
                      style: GoogleFonts.poppins(
                        textStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 13 * scaleFactor,
                          color: onSurface.withOpacity(0.75),
                        ),
                      ),
                    ),
                    SizedBox(height: 22 * scaleFactor),

                    /// Star rating emojis
                    Obx(() {
                      final themeColor = brightness == Brightness.dark
                          ? const Color.fromARGB(255, 242, 198, 65)
                          : Colors.pink;

                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(stars.length, (index) {
                              final selected =
                                  controller.selectedStar.value == index;
                              return GestureDetector(
                                onTap: () => controller.setStar(index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.015,
                                  ),
                                  padding: EdgeInsets.all(12 * scaleFactor),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selected
                                        ? themeColor.withOpacity(0.25)
                                        : Colors.transparent,
                                    boxShadow: selected
                                        ? [
                                            BoxShadow(
                                              color:
                                                  themeColor.withOpacity(0.4),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Text(
                                    stars[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: selected
                                          ? 38 * scaleFactor
                                          : 30 * scaleFactor,
                                      color:
                                          selected ? themeColor : onSurface,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 28 * scaleFactor),

                    /// Feedback input
                    Text(
                      'Do you have any thoughts you\'d like to share?',
                      style: GoogleFonts.poppins(
                        textStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize:15 * scaleFactor,
                          color: onSurface,
                        ),
                      ),
                    ),
                    SizedBox(height: 12 * scaleFactor),

                    Obx(() {
                      return TextField(
                        maxLines: 5,
                        onChanged: controller.setFeedbackText,
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: controller.feedbackText.value,
                            selection: TextSelection.collapsed(
                              offset: controller.feedbackText.value.length,
                            ),
                          ),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write your feedback here...',
                          hintStyle: GoogleFonts.poppins(
                            color: onSurface.withOpacity(0.45),
                            fontSize: 12 * scaleFactor,
                          ),
                          filled: true,
                          fillColor: brightness == Brightness.light
                              ? Colors.grey[100]
                              : Colors.grey[900],
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16 * scaleFactor,
                            horizontal: 16 * scaleFactor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(14 * scaleFactor),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(14 * scaleFactor),
                            borderSide: BorderSide(
                              color: brightness == Brightness.dark
                                  ? const Color.fromARGB(255, 242, 198, 65)
                                  : Colors.pink,
                              width: 2,
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          color: onSurface,
                          fontSize: 16 * scaleFactor,
                          height: 1.3,
                        ),
                      );
                    }),
                    SizedBox(height: 24 * scaleFactor),

                    /// Follow-up
                    Text(
                      'May we follow you up on your feedback?',
                      style: GoogleFonts.poppins(
                        textStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15 * scaleFactor,
                          color: onSurface,
                        ),
                      ),
                    ),
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: Text(
                                'Yes',
                                style: GoogleFonts.poppins(
                                  fontSize: 14 * scaleFactor,
                                ),
                              ),
                              value: true,
                              groupValue: controller.followUp.value,
                              onChanged: controller.setFollowUp,
                              activeColor: brightness == Brightness.dark
                                  ? const Color.fromARGB(255, 242, 198, 65)
                                  : Colors.pink,
                              contentPadding: EdgeInsets.only(
                                right: 6 * scaleFactor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: Text(
                                'No',
                                style: GoogleFonts.poppins(
                                  fontSize: 14 * scaleFactor,
                                ),
                              ),
                              value: false,
                              groupValue: controller.followUp.value,
                              onChanged: controller.setFollowUp,
                              activeColor: brightness == Brightness.dark
                                  ? const Color.fromARGB(255, 242, 198, 65)
                                  : Colors.pink,
                              contentPadding: EdgeInsets.only(
                                left: 6 * scaleFactor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 32 * scaleFactor),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.sendFeedback();
                              controller.cancel();
                              showFeedbackDialogAndNavigate();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 16 * scaleFactor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12 * scaleFactor),
                              ),
                              backgroundColor: brightness == Brightness.dark
                                  ? const Color.fromARGB(255, 242, 198, 65)
                                  : Colors.pink,
                              elevation: 4,
                            ),
                            child: Text(
                              'Send',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17 * scaleFactor,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 14 * scaleFactor),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: controller.cancel,
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 16 * scaleFactor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12 * scaleFactor),
                              ),
                              side: BorderSide(
                                color: brightness == Brightness.dark
                                    ? const Color.fromARGB(255, 245, 243, 243)
                                    : Colors.pink,
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17 * scaleFactor,
                                color: brightness == Brightness.dark
                                    ? const Color.fromARGB(255, 242, 198, 65)
                                    : Colors.pink,
                              ),
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
        ),
      ),
    );
  }
}
