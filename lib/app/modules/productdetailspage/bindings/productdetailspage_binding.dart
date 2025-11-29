import 'package:get/get.dart';

import '../controllers/productdetailspage_controller.dart';

class ProductdetailspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductdetailspageController>(
      () => ProductdetailspageController(),
    );
  }
}
