import 'package:get/get.dart';

import '../controllers/addcartpageviews_controller.dart';

class AddcartpageviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddcartpageviewsController>(
      () => AddcartpageviewsController(),
    );
  }
}
