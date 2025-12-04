import 'package:get/get.dart';

import '../controllers/categorydetailspage_controller.dart';


class CategoryDetailspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryDetailspageController>(
          () => CategoryDetailspageController(),
      fenix: true,
    );
  }
}