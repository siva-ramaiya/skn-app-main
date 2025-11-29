import 'package:get/get.dart';

import '../controllers/myorderpage_controller.dart';

class MyorderpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyorderpageController>(
      () => MyorderpageController(),
    );
  }
}
