import 'package:get/get.dart';

import '../controllers/splashscreenpage_controller.dart';

class SplashscreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenpageController>(
      () => SplashscreenpageController(),
    );
  }
}
