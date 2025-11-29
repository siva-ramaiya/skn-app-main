import 'package:get/get.dart';

import '../controllers/noodelsscreenpage_controller.dart';

class NoodelsscreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoodelsscreenpageController>(
      () => NoodelsscreenpageController(),
    );
  }
}
