import 'package:get/get.dart';

import '../controllers/registerpage_controller.dart';

class RegisterpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterpageController>(
      () => RegisterpageController(),
    );
  }
}
