import 'package:get/get.dart';

import '../controllers/orderhistorypage_controller.dart';

class OrderhistorypageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderhistorypageController>(
      () => OrderhistorypageController(),
    );
  }
}
