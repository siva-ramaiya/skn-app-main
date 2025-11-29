import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/onboardingscreen/views/onboardingscreen_view.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:foodapp/app/utils/storage_helper.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashscreenpageView extends StatefulWidget {
  const SplashscreenpageView({super.key});

  @override
  State<SplashscreenpageView> createState() => _SplashscreenpageViewState();
}

class _SplashscreenpageViewState extends State<SplashscreenpageView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      final token = StorageHelper.getToken();

      print('Splashscreen Token: $token');

      if (token != null && token.isNotEmpty) {
        // User already logged in → Go Home
        Get.offAll(() => BottomnavigationbarView());
      } else {
        // No token → Show Onboarding
        Get.offAll(() => OnboardingscreenView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/Delivery.json',
              width: size.width * 0.5,
              height: size.height * 0.35,
            ),
          ],
        ),
      ),
    );
  }
}
