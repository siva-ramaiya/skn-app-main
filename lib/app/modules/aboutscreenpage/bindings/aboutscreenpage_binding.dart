import 'package:get/get.dart';

import '../controllers/aboutscreenpage_controller.dart';

class AboutscreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutpageController>(
      () => AboutpageController(),
    );
  }
}
