import 'package:get/get.dart';

import '../controllers/phonescreenpage_controller.dart';

class PhonescreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhonescreenpageController>(
      () => PhonescreenpageController(),
    );
  }
}
