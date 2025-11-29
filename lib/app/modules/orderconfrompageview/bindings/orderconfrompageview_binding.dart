import 'package:get/get.dart';

import '../controllers/orderconfrompageview_controller.dart';

class OrderconfrompageviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderconfrompageviewController>(
      () => OrderconfrompageviewController(),
    );
  }
}
