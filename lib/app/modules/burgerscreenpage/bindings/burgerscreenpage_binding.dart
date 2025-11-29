import 'package:get/get.dart';

import '../controllers/burgerscreenpage_controller.dart';

class BurgerscreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BurgerscreenpageController>(
      () => BurgerscreenpageController(),
    );
  }
}
