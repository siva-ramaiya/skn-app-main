import 'package:get/get.dart';

import '../controllers/bottomnavgationbar_controller.dart';

class BottomnavgationbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomnavgationbarController>(
      () => BottomnavgationbarController(),
    );
  }
}
