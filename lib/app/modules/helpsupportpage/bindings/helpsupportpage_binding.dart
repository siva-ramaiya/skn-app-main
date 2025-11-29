import 'package:get/get.dart';

import '../controllers/helpsupportpage_controller.dart';

class HelpsupportpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpsupportpageController>(
      () => HelpsupportpageController(),
    );
  }
}
