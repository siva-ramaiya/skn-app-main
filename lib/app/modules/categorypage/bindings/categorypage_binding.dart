import 'package:get/get.dart';

import '../controllers/categorypage_controller.dart';

class CategorypageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategorypageController>(
      () => CategorypageController(),
    );
  }
}
