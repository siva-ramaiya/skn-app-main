import 'package:foodapp/app/modules/loginpage/views/loginpage_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingscreenController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboscreen2.jpg",
      "title": "Get the exact nutrition value of everything you eat",
      "highlight": "exact nutrition",
      "subtitle":
          "We are updating our food database every minute to help you track your calories.",
    },
    {
      "image": "assets/images/onboscreen3.jpg",
      "title": "Discover fresh and healthy meal options",
      "highlight": "fresh and healthy",
      "subtitle":
          "Choose from a variety of nutritious dishes to suit your lifestyle.",
    },
    {
      "image": "assets/images/onboscreen4.jpg",
      "title": "Satisfy your cravings without guilt",
      "highlight": "without guilt",
      "subtitle":
          "Indulge in desserts that are both delicious and health-friendly.",
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value == onboardingData.length - 1) {
      Get.to(LoginpageView());
    } else {
      pageController.nextPage(
        duration:  Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
