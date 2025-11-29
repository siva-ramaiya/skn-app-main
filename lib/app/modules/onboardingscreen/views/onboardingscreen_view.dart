import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/onboardingscreen_controller.dart';

class OnboardingscreenView extends GetView<OnboardingscreenController> {
  const OnboardingscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery values
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.onboardingData.length,
                itemBuilder: (context, index) {
                  final data = controller.onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Food Image with responsive size
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: size.width * 0.6,
                            height: size.width * 0.6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber.withOpacity(0.15),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              size.width * 0.3,
                            ),
                            child: Image.asset(
                              data["image"]!,
                              // width: size.width * 0.55,
                              height: size.width * 0.55,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
          
                      SizedBox(height: size.height * 0.04),
          
                      // Title
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: size.width * 0.040,
                              color: theme.textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: data["title"]!.split(
                                  data["highlight"]!,
                                )[0],
                              ),
                              TextSpan(
                                text: data["highlight"]!,
                                style: GoogleFonts.poppins(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.040,
                                ),
                              ),
                              TextSpan(
                                text: data["title"]!.split(
                                  data["highlight"]!,
                                )[1],
                              ),
                            ],
                          ),
                        ),
                      ),
          
                      SizedBox(height: size.height * 0.015),
          
                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                        ),
                        child: Text(
                          data["subtitle"]!,
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.032,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          
            // Indicator dots
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: controller.currentPage.value == index
                        ? size.width * 0.05
                        : size.width * 0.02,
                    height: size.width * 0.02,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? Colors
                                .pink 
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          
            SizedBox(height: size.height * 0.04),
          
            // Next Button
            InkWell(
              onTap: controller.nextPage,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: size.width * 0.13,
                height: size.width * 0.13,
                decoration: BoxDecoration(
                   border: Border.all(
                      color: isDark?Colors.white:Colors.white,
                   ),
                  shape: BoxShape.circle,
                    color: Get.isDarkMode ? const Color.fromARGB(255, 241, 203, 90) : Colors.pink,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: size.width * 0.06,
                ),
              ),
            ),
          
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
