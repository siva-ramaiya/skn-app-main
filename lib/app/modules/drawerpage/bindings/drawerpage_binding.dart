import 'package:get/get.dart';

import '../controllers/drawerpage_controller.dart';

class DrawerpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawerpageController>(
      () => DrawerpageController(),
    );
  }
}
