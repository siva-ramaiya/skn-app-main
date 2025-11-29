import 'package:get/get.dart';

import '../controllers/onboardingscreen_controller.dart';

class OnboardingscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingscreenController>(
      () => OnboardingscreenController(),
    );
  }
}
