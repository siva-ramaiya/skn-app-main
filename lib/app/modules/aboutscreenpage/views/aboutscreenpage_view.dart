import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/aboutscreenpage/controllers/aboutscreenpage_controller.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutpageView extends StatefulWidget {
  const AboutpageView({super.key});

  @override
  State<AboutpageView> createState() => _AboutpageViewState();
}

class _AboutpageViewState extends State<AboutpageView>
    with TickerProviderStateMixin {
  double _opacity = 0.0;
  late final AboutpageController controller;
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<AboutpageController>()) {
      Get.put(AboutpageController());
    }
    controller = Get.find<AboutpageController>();

    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _fadeInController,
      curve: Curves.easeIn,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _opacity = 1.0);
      _fadeInController.forward();
    });
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 600;
    final bool isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final double titleSize = isWeb ? 22 : 18;
    final double sectionTitleSize = isWeb ? 18 : 14;
    final double bodyTextSize = isWeb ? 16 : 13;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: isDark
              ? const Color.fromARGB(255, 249, 209, 88)
              : Colors.pink,
          title: Text(
            "About",
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => BottomnavigationbarView());
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Background Image with Fade Zoom Animation
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 8),
                tween: Tween(begin: 1.0, end: 1.1),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: 0.05,
                      child: Image.asset(
                        "assets/images/aboutpage.png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: isDark ? Colors.black : Colors.white,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // Custom Back Button
            // Positioned(
            //   top: 16,
            //   left: 16,
            //   child: Material(
            //     color: Colors.transparent,
            //     shape: const CircleBorder(),
            //     child: InkWell(
            //       customBorder: CircleBorder(),
            //       onTap: () {
            //         // Always navigate directly to home (BottomnavigationbarView)
            //         Get.offAll(() => BottomnavigationbarView());
            //       },

            //       child: Container(
            //         padding: const EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //           color: isDark ? const Color(0xFFF8D363) : Colors.pink,
            //           shape: BoxShape.circle,
            //           boxShadow: const [
            //             BoxShadow(
            //               color: Colors.black26,
            //               blurRadius: 4,
            //               offset: Offset(2, 2),
            //             ),
            //           ],
            //         ),
            //         child: Icon(
            //           Icons.arrow_back,
            //           color: Colors.white,
            //           size: 22,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Main Content
            FadeTransition(
              opacity: _fadeInAnimation,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isWeb ? 32 : 16,
                  70,
                  isWeb ? 32 : 16,
                  16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWeb ? 800 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionCard(
                          title: "Our Heritage",
                          content:
                              "S. Kandasamy & Sons is a well-established vegetable and fruit shop located near K.P. Road in Chetti Kulam, Nagercoil. Since 1961, we have been proudly serving our community with the finest quality produce.\n\nFor over 60 years, our family business has grown while maintaining the core values that our founder established: quality, freshness, and customer satisfaction. We are known throughout Nagercoil for providing a wide range of products, including regular vegetables and imported fruits.",
                          theme: theme,
                          titleSize: sectionTitleSize,
                          bodySize: bodyTextSize,
                        ),
                        const SizedBox(height: 20),
                        _sectionCard(
                          title: "Our Products",
                          content:
                              "* Fresh Local Vegetables\n* Premium Imported Fruits\n* Seasonal Specialties\n* Organic Options",
                          theme: theme,
                          titleSize: sectionTitleSize,
                          bodySize: bodyTextSize,
                        ),
                        const SizedBox(height: 20),
                        _sectionCard(
                          title: "Why Choose Us",
                          content:
                              "* 60+ Years of Experience\n* Dedicated Staff\n* Multiple Payment Options\n* Extended Operating Hours",
                          theme: theme,
                          titleSize: sectionTitleSize,
                          bodySize: bodyTextSize,
                        ),
                        const SizedBox(height: 20),
                        _sectionCard(
                          title: "Our Commitment",
                          content:
                              "We take pride in our dedicated staff who work tirelessly to ensure every customer receives the best service and the freshest produce. Our convenient operating hours from 7:00 AM to 11:00 PM make it easy for you to shop at your convenience. We offer various payment options to serve you better.\n\nAt S. Kandasamy & Sons, we don't just sell fruits and vegetables – we share our passion for fresh, healthy food with every customer who walks through our doors.",
                          theme: theme,
                          titleSize: sectionTitleSize,
                          bodySize: bodyTextSize,
                        ),
                        const SizedBox(height: 46),
                        _sectionTitle("Get in Touch", theme, sectionTitleSize),
                        const SizedBox(height: 10),
                        _contactText(
                          "Email",
                          "SKN18@gmail.com",
                          recognizer: controller.emailRecognizer,
                          theme: theme,
                          bodySize: bodyTextSize,
                        ),
                        const SizedBox(height: 15),
                        _contactText(
                          "Phone",
                          "+91 93451 31081",
                          recognizer: controller.phoneRecognizer,
                          theme: theme,
                          bodySize: bodyTextSize,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, ThemeData theme, double fontSize) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: theme.textTheme.titleLarge?.color,
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required String content,
    required ThemeData theme,
    required double titleSize,
    required double bodySize,
  }) {
    final processedContent = content.startsWith('*')
        ? content.split('\n').map((line) => line.trim().substring(2)).toList()
        : [content];

    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: titleSize,
              ),
            ),
            const SizedBox(height: 10),
            ...processedContent.map((text) {
              if (content.startsWith('*')) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: bodySize,
                          fontWeight: FontWeight.bold,
                          color: theme.hintColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          text,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: bodySize,
                            color: theme.hintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Text(
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: bodySize,
                    color: theme.hintColor,
                  ),
                );
              }
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _contactText(
    String label,
    String value, {
    required TapGestureRecognizer recognizer,
    required ThemeData theme,
    required double bodySize,
  }) {
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyMedium?.copyWith(fontSize: bodySize),
        children: [
          TextSpan(
            text: "$label: ",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: bodySize,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.poppins(
              fontSize: bodySize,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}
