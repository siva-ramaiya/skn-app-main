import 'package:get/get.dart';

import '../controllers/optscreenpage_controller.dart';

class OptscreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptscreenpageController>(
      () => OptscreenpageController(),
    );
  }
}
