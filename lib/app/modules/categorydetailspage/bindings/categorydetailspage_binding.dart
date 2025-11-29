import 'package:get/get.dart';

import '../controllers/categorydetailspage_controller.dart';

class PizzascreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryDetailspageController>(
      () => CategoryDetailspageController(),
    );
  }
}
